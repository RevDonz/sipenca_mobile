import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sipenca_mobile/firebase/auth.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';

class NeedsService {
  static Future<void> addKebutuhan(String kebutuhan, String kategori) async {
    Map<String, dynamic>? userData =
        await DatabaseService.getDetailUsers(AuthService.getCurrentUserID());

    await FirebaseFirestore.instance.collection('kebutuhan').add({
      'pengungsian': userData!['pengungsian'],
      'kebutuhan': kebutuhan,
      'kategori': kategori
    });
  }

  static Future<List<Map<String, dynamic>>> getAllKebutuhan() async {
    List<Map<String, dynamic>> listKebutuhan = [];

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('kebutuhan').get();

    snapshot.docs.forEach((element) {
      listKebutuhan.add(element.data());
    });

    return listKebutuhan;
  }
}
