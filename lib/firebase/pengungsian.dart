import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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


  Future<List<Map<String, dynamic>?>> getAllUsers() async {
    List<Map<String, dynamic>> listUser = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    snapshot.docs.forEach((element) {
      listUser.add(element.data());
    });

    return listUser;
  }

  Future<Map<String, dynamic>?> getDetailUsers(String documentId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(documentId).get();

    // return snapshot;
    Map<String, dynamic>? res = await snapshot.data();

    return res;
  }
}
