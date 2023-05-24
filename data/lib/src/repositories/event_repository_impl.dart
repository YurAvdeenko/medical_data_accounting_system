import 'dart:async';

import 'package:data/src/model/event.dart' as data;
import 'package:data/src/providers/event_provider.dart';
import 'package:data/src/providers/user_provider.dart';
import 'package:domain/domain.dart' as domain;
import 'package:intl/intl.dart';

class EventRepositoryImpl implements domain.EventRepository {
  final EventProvider _eventProvider;
  final UserProvider _userProvider;

  EventRepositoryImpl({
    required EventProvider eventProvider,
    required UserProvider userProvider,
  })  : _eventProvider = eventProvider,
        _userProvider = userProvider;

  @override
  Stream<Future<List<domain.Event>>> observeAll() {
    final String userId = _userProvider.getCurrent()?.id ?? '';
    return _eventProvider.observeAllByUserId(userId).map(
      (final List<data.Event> dataEventList) async {
        //data to domain
        return dataEventList.where((data.Event event) => event.userId == userId).map((data.Event event) {
          return domain.Event(
            id: event.id,
            userId: event.userId,
            doctor: event.doctor,
            illness: event.illness,
            illnessDescription: event.illnessDescription,
            date:  DateFormat('MMM dd, yyyy, HH:mm').parse(event.date),
          );
        }).toList();
      },
    );
  }

  @override
  Future<void> deleteById(String eventId)  {
    return _eventProvider.deleteById(eventId);
  }

  @override
  Future<void> uploadNewEvent(domain.EventParams params) async {
    final String userId = _userProvider.getCurrent()?.id ?? '';
    await _eventProvider.insert(
      userId,
      params.doctor,
      params.illness,
      params.illnessDescription,
      params.date ?? DateTime.now(),
    );
  }
}
