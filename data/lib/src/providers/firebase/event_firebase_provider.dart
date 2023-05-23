import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/src/mappers/firebase/event_firebase_mapper.dart';
import 'package:data/src/model/event.dart' as data;
import 'package:data/src/providers/event_provider.dart';

const String COLLECTION_EVENT = 'event';

class EventFirebaseProvider implements EventProvider {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Future<void> insert(String id, String doctor, String illness, String illnessDescription, DateTime date) async {
    final DocumentReference<Map<String, dynamic>> doc = _fireStore.collection(COLLECTION_EVENT).doc();

    await doc.set(
      <String, dynamic>{
        'user_id': id,
        'doctor': doctor,
        'illness': illness,
        'illness_description': illnessDescription,
        'date': date,
      },
    );
  }

  @override
  Stream<List<data.Event>> getCurrentEvents(String userId) {
    return _fireStore.collection(COLLECTION_EVENT).snapshots().map(
      (QuerySnapshot<Map<String, dynamic>> event) {
        return event.docs
            .where(
              (QueryDocumentSnapshot<Map<String, dynamic>> doc) {
                final Map<String, dynamic> docMap = doc.data();

                final docUserId = docMap[FIELD_EVENT_USER_ID];
                return docUserId == userId;
              },
            )
            .map(
              (QueryDocumentSnapshot<Map<String, dynamic>> doc) => EventFirebaseToDataMapper.fromMap(
                map: doc.data(),
                id: doc.id,
              ),
            )
            .toList();
      },
    );
  }
}
