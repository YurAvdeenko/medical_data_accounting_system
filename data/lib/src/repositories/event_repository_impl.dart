import 'dart:async';

import 'package:data/src/model/event.dart' as data;
import 'package:data/src/providers/event_provider.dart';
import 'package:data/src/providers/user_provider.dart';
import 'package:domain/domain.dart' as domain;

class EventRepositoryImpl implements domain.EventRepository {
  final EventProvider _eventProvider;
  final UserProvider _userProvider;

  EventRepositoryImpl({
    required EventProvider eventProvider,
    required UserProvider userProvider,
  })  : _eventProvider = eventProvider,
        _userProvider = userProvider;

  @override
  Stream<Future<List<domain.Event>>> getCurrentEvents() {
    return _eventProvider.getCurrentEvents((_userProvider.getCurrent())!.id).map(
      (final List<data.Event> dataEventList) async {
        //todo remove?
        final List<String> eventIds = dataEventList.map((data.Event event) => event.id).toSet().toList();

        //data to domain
        return dataEventList
            .map((data.Event event) => domain.Event(
                id: event.id,
                doctor: event.doctor,
                illness: event.illness,
                illnessDescription: event.illnessDescription,
                date: event.date))
            .toList();
      },
    );
  }

  //todo handle this one
  // @override
  // Future<domain.Event?> uploadNewEvent(domain.EventParams params) async {
  //   final data.Event? event = await _eventProvider.insert(
  //     params.id,
  //     params.doctor,
  //     params.illness,
  //     params.illnessDescription,
  //     params.date ?? DateTime.now(),
  //   );
  //   if (event == null) {
  //     return null;
  //   } else {
  //     return domain.Event(
  //       id: event.id,
  //       doctor: event.doctor,
  //       illness: event.illness,
  //       illnessDescription: event.illnessDescription,
  //       date: event.date,
  //     );
  //   }
  // }
}
