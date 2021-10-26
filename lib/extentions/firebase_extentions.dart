import 'package:cloud_firestore/cloud_firestore.dart';

extension FirebaseFireStoreX on FirebaseFirestore {
  DocumentReference<Map<String, dynamic>> userRefrence(String userID) =>
      collection('UserInfo').doc(userID);

  CollectionReference<Map<String, dynamic>> placesRefrence(String userID) =>
      collection('UserInfo').doc(userID).collection('places');
}
