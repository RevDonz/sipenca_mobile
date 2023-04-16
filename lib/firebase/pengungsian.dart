import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<String?> addAkun(
      {required String email,
      required String role,
      required String password}) async {
    try {
      CollectionReference akun = FirebaseFirestore.instance.collection("akun");
      await akun.doc(email).set({'role': role, 'password': password});

      return 'Success';
    } catch (e) {
      return 'Error register user';
    }
  }

  Future<String?> getAkun({required String email}) async {
    try {
      CollectionReference akun = FirebaseFirestore.instance.collection("akun");
      final response = await akun.doc(email).get();
      final data = response.data() as Map<String, dynamic>;
      return data['username'];
    } catch (e) {
      return 'Error fetch akun';
    }
  }
}
