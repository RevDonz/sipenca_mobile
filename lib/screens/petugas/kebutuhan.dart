import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../components/appBar.dart';
import '../../firebase/auth.dart';
import '../../firebase/pengungsian.dart';
import '../warga/profile.dart';
import 'warga.dart';

class DetailPengungsianPetugas extends StatefulWidget {
  const DetailPengungsianPetugas({super.key});

  @override
  State<DetailPengungsianPetugas> createState() => _DetailPengungsianState();
}

class _DetailPengungsianState extends State<DetailPengungsianPetugas> {
  List<Map<String, dynamic>> dataPengungsi = [];
  Map<String, dynamic>? profilePetugas;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      if (element.data()['occupied'] == userData!['pengungsian']) {
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
    List<Widget> widgetOptions = <Widget>[
      const PengungsiWarga(),
      const DetailPengungsianPetugas(),
      ProfilePage(profileWarga: profilePetugas),
    ];

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const AppBarSipenca(role: "Petugas"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text('Pengungsi ditampung')],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: dataPengungsi.length,
              itemBuilder: (context, index) {
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
                            if (dataPengungsi[index]['pulang'])
                              FloatingActionButton(
                                heroTag: "btnPengungsi$index",
                                onPressed: () {
                                  Map<String, dynamic> data =
                                      dataPengungsi[index];
                                  data['occupied'] = '';
                                  data['reserve'] = '';
                                  data['pulang'] = false;
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
