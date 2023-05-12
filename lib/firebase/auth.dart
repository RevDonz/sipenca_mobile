import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Method untuk login user
  static Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>> getDetailUsers(User user) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();
    QueryDocumentSnapshot<Map<String, dynamic>> document = snapshot.docs[0];
    Map<String, dynamic> res = document.data();
    return res;
  }

  // Method untuk logout user
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  static Future<UserCredential?> registerAccount(
      String email, String password) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
