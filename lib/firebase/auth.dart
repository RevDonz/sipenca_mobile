import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
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

  // Method untuk logout user
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static String getCurrentUserID() {
    final User? user = FirebaseAuth.instance.currentUser;
    final String userID = user!.uid;
    return userID;
  }

  static Future<void> registerAccount(
      String email, String password, String role) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (role == "petugas") {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .set({
          'alamat': "",
          'email': email,
          'full_name': "",
          'jenis_kelamin': "",
          'nik': "",
          'no_hp': "",
          'password': password,
          'pengungsian': "",
          'role': role,
          'tgl_lahir': ""
        });

        print('Registered user: ${user?.uid}');
      } else if (role == "warga") {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .set({
          'alamat': "",
          'email': email,
          'full_name': "",
          'jenis_kelamin': "",
          'nik': "",
          'no_hp': "",
          'occupied': "",
          'reserve': "",
          'role': role,
          'tgl_lahir': ""
        });

        print('Registered user: ${user?.uid}');
      }
      // Simpan data pengguna ke koleksi "users" di Firestore
    } catch (e) {
      // Handle error jika terjadi kesalahan
      print(e.toString());
    }
  }
}
