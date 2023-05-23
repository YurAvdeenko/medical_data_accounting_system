import 'package:data/src/model/event.dart' as data;

const String FIELD_EVENT_USER_ID = 'user_id';
const String FIELD_EVENT_DOCTOR = 'doctor';
const String FIELD_EVENT_ILLNESS = 'illness';
const String FIELD_EVENT_ILLNESS_DESCRIPTION = 'illness_description';
const String FIELD_EVENT_DATE = 'date';

class EventFirebaseToDataMapper {
  static data.Event fromMap({
    required Map<String, dynamic> map,
    required String id,
  }) {
    if (<String>{
      FIELD_EVENT_USER_ID,
      FIELD_EVENT_DOCTOR,
      FIELD_EVENT_ILLNESS,
      FIELD_EVENT_ILLNESS_DESCRIPTION,
      FIELD_EVENT_DATE,
    }.every((String field) => map.keys.contains(field))) {
      return data.Event(
        id: map[FIELD_EVENT_USER_ID] as String,
        doctor: map[FIELD_EVENT_DOCTOR] as String,
        illness: map[FIELD_EVENT_ILLNESS] as String,
        illnessDescription: map[FIELD_EVENT_ILLNESS_DESCRIPTION] as String,
        date: map[FIELD_EVENT_DOCTOR] as DateTime,
      );
    } else {
      throw Exception('Missing keys (${<String>{
        FIELD_EVENT_USER_ID,
        FIELD_EVENT_DOCTOR,
        FIELD_EVENT_ILLNESS,
        FIELD_EVENT_ILLNESS_DESCRIPTION,
        FIELD_EVENT_DATE,
      }.difference(map.keys.toSet())}) while mapping');
    }
  }
}

extension EventDataToFirebase on data.Event {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FIELD_EVENT_USER_ID: id,
      FIELD_EVENT_DOCTOR: doctor,
      FIELD_EVENT_ILLNESS: illness,
      FIELD_EVENT_ILLNESS_DESCRIPTION: illnessDescription,
      FIELD_EVENT_DATE: date,
    };
  }
}
