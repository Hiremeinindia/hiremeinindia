import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get user details from Firestore
  Future<Map<String, dynamic>?> getUserDetails(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('corporateuser').doc(uid).get();

      return snapshot.data();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}
