import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home/src/home_screen/bloc/home_event.dart';
import 'package:home/src/home_screen/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final Connectivity _connectivity = Connectivity();

  HomeBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  })  : _authRepository = authRepository,
        _userRepository = userRepository,
        super(HomeState.initState()) {
    on<GetUser>(_onGetUser);
    on<Logout>(_onLogout);
    on<CheckOfflineMode>(_onCheckOfflineMode);
    on<SubmitDataEvent>(_onSubmitDataEvent);
    on<RemoveDataEvent>(_onRemoveDataEvent);

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
  }

  Future<void> _onGetUser(
    _,
    Emitter<HomeState> emit,
  ) async {
    emit(
      state.copyWith(
        currentUser: await _userRepository.getCurrent(),
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

  void _onRemoveDataEvent(
      RemoveDataEvent event,
    Emitter<HomeState> emit,
  ) {
    List<Event> currentEvents = <Event>[...state.events];

    currentEvents.removeAt(event.index);
    emit(
      state.copyWith(events: currentEvents),
    );
  }
}
