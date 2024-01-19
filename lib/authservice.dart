import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password, String role) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = authResult.user;

      // Add user to Firestore with role
      if (user != null) {
        // Customize this part based on your Firestore structure
        // Use 'users' for regular users and 'admins' for admin users
        await FirebaseFirestore.instance
            .collection(role == 'admin' ? 'admins' : 'users')
            .doc(user.uid)
            .set({
          'uid': user.uid,
          'email': email,
          'role': role,
          // Add other user information as needed
        });
      }

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return authResult.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
