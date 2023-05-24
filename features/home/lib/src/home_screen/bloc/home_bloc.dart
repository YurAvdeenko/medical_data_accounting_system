import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home_screen/bloc/home_event.dart';
import 'package:home/src/home_screen/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final EventRepository _eventRepository;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<Future<List<Event>>>? _allEventsListener;

  HomeBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required EventRepository eventRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        _eventRepository = eventRepository,
        super(HomeState.initState()) {
    on<Logout>(_onLogout);
    on<CheckOfflineMode>(_onCheckOfflineMode);
    on<SubmitDataEvent>(_onSubmitDataEvent);
    on<RemoveEvent>(_onRemoveEvent);
    on<EventsUpdated>(_onEventsUpdated);
    on<UploadEvent>(_onUploadEvent);
    on<Init>(_onInit);

    add(const Init());
  }

  Future<void> _onInit(
    _,
    Emitter<HomeState> emit,
  ) async {
    _connectivity.onConnectivityChanged.listen(
      (event) {
        if (event == ConnectivityResult.none) {
          add(
            CheckOfflineMode(
              isInternetAvailable: false,
            ),
          );
        } else {
          add(
            CheckOfflineMode(
              isInternetAvailable: true,
            ),
          );
        }
      },
    );

    _allEventsListener ??= _eventRepository.observeAll().listen(
      (Future<List<Event>> eventActivities) async {
        add(
          EventsUpdated(
            allEvents: await eventActivities,
          ),
        );
      },
    );

    final User user = await _userRepository.getCurrent();

    emit(
      state.copyWith(
        currentUser: user,
      ),
    );
  }

  Future<void> _onLogout(
    _,
    Emitter<HomeState> emit,
  ) async {
    _authRepository.signOut();
  }

  Future<void> _onCheckOfflineMode(
    CheckOfflineMode event,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        isInternetAvailable: event.isInternetAvailable,
      ),
    );
  }

  void _onSubmitDataEvent(
    SubmitDataEvent event,
    Emitter<HomeState> emit,
  ) {
    List<Event> currentEvents = <Event>[...state.events];

    currentEvents.add(event.value);
    emit(
      state.copyWith(events: currentEvents),
    );
  }

  Future<void> _onRemoveEvent(
    RemoveEvent event,
    _,
  ) async {
    await _eventRepository.deleteById(event.eventId);
  }

  void _onEventsUpdated(
    EventsUpdated event,
    Emitter<HomeState> emit,
  ) {
    emit(
      state.copyWith(
        events: event.allEvents,
        isLoading: false,
      ),
    );
  }

  Future<void> _onUploadEvent(
    UploadEvent event,
    Emitter<HomeState> emit,
  ) async {
    final User? user = state.currentUser;
    if (user == null) return;

    await _eventRepository.uploadNewEvent(
      EventParams(
        userId: user.id,
        doctor: event.doctor,
        illness: event.illness,
        illnessDescription: event.illnessDescription,
        date: event.date,
      ),
    );
  }

  @override
  Future<void> close() async {
    _allEventsListener?.cancel();
    _allEventsListener = null;
    super.close();
  }
}
