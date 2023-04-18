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

  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    List<Map<String, dynamic>> listUser = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    snapshot.docs.forEach((element) {
      listUser.add(element.data());
    });

    return listUser;
  }

  static Future<Map<String, dynamic>?> getDetailUsers(String documentId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(documentId)
        .get();

    // return snapshot;
    Map<String, dynamic>? res = snapshot.data();

    return res;
  }

  static Future<List<Map<String, dynamic>>> getAllPengungsian() async {
    List<Map<String, dynamic>> listPengungsian = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('pengungsians').get();

    snapshot.docs.forEach((element) {
      listPengungsian.add(element.data());
    });

    return listPengungsian;
  }
}
