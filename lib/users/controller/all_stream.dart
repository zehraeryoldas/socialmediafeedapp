import 'package:cloud_firestore/cloud_firestore.dart';

class AllStream {
  Stream<QuerySnapshot> getAllStream() {
    return FirebaseFirestore.instance
        .collection('items')
        .orderBy('time_stamp', descending: true)
        .snapshots();
  }
}
