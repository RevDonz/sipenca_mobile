import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  static Future<void> updateData(
      String documentId, Map<String, dynamic>? data) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(documentId)
          .update(data!);
    } catch (e) {
      // Handle error jika terjadi kesalahan
      print(e.toString());
    }
  }

  static Future<String> getDocumentIdFromQuery(
      String collection, String field, String value) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(collection)
        .where(field, isEqualTo: value)
        .get();

    if (querySnapshot.size > 0) {
      QueryDocumentSnapshot documentSnapshot = querySnapshot.docs[0];
      return documentSnapshot.id;
    } else {
      return "";
    }
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
