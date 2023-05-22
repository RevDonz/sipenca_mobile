import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';
import 'package:sipenca_mobile/firebase/auth.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';

class accWarga extends StatefulWidget {
  const accWarga({super.key});

  @override
  State<accWarga> createState() => _accWargaState();
}

class _accWargaState extends State<accWarga> {
  List<Map<String, dynamic>> dataPengungsi = [];
  Map<String, dynamic>? profilePetugas;

  void getProfile() async {
    Map<String, dynamic>? userData =
        await DatabaseService.getDetailUsers(AuthService.getCurrentUserID());

    setState(() {
      profilePetugas = userData;
    });
  }

  void getListPengungsi() async {
    List<Map<String, dynamic>> list = [];
    QuerySnapshot<Map<String, dynamic>> snap =
        await FirebaseFirestore.instance.collection('users').get();

    Map<String, dynamic>? userData =
        await DatabaseService.getDetailUsers(AuthService.getCurrentUserID());

    snap.docs.forEach((element) {
      if (element.data()['reserve'] == userData!['pengungsian']) {
        Map<String, dynamic> data = element.data();
        data['id'] = element.id;
        list.add(data);
      }
    });
    setState(() {
      dataPengungsi = list;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfile();
    getListPengungsi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const AppBarSipenca(role: "Petugas"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text('Pengungsi yang datang')],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: dataPengungsi.length,
              itemBuilder: (context, index) {
                // String jarak;
                // if (dataPengungsi[index]["jarak"] >= 1000) {
                //   jarak = "${dataPengungsi[index]["jarak"] / 1000} KM";
                // } else {
                //   jarak = "${dataPengungsi[index]["jarak"]} M";
                // }
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(dataPengungsi[index]['full_name']),
                                // Text(jarak),
                                // Text("${dataPengungsi[index]['member']}orang"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(dataPengungsi[index]['alamat']),
                            ),
                            FloatingActionButton(
                              heroTag: "btnPengungsi$index",
                              onPressed: () {
                                Map<String, dynamic> data =
                                    dataPengungsi[index];
                                data['occupied'] = data['reserve'];
                                data['reserve'] = '';
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(dataPengungsi[index]['id'])
                                    .update(data);
                                setState(() {
                                  getListPengungsi();
                                });
                              },
                              backgroundColor: Colors.indigoAccent,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: const Icon(Icons.input),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ]),
        ),
      )),
    );
  }
}
