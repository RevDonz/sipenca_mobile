import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';

class ListPengungsi extends StatefulWidget {
  const ListPengungsi({super.key});

  @override
  State<ListPengungsi> createState() => _ListPengungsiState();
}

class _ListPengungsiState extends State<ListPengungsi> {
  Map<String, dynamic>? user;
  List<Map<String, dynamic>> dataPengungsi = [];

  // List<Map<String, dynamic>> dataPengungsi = [
  //   {
  //     "alamat": "Bandung",
  //     "email": "aprilio842@gmail.com",
  //     "full_name": "Reva Doni Aprilio",
  //     "jenis_kelamin": "Laki-laki",
  //     "nik": "320xxx",
  //     "no_hp": "089xxx",
  //     "occupied": "",
  //     "reserve": "",
  //     "role": "warga",
  //     "tgl_lahir": "08-04-2002"
  //   }
  // ];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Scaffold(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Scaffold(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        user =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      });
    });
    getListPengungsi();
  }

  void getListPengungsi() async {
    List<Map<String, dynamic>> list = [];
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection('users')
        .where('reserve', isEqualTo: user?['pengungsian'])
        .get();
    snap.docs.forEach((element) {
      list.add(element.data());
    });
    // List<Map<String, dynamic>> list =
    //     await DatabaseService.getPengungsiOnPengungsian(user?['pengungsian']);

    // print(user?['pengungsian']);
    setState(() {
      dataPengungsi = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: data['full_name'] as String,
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Pengungsian',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigoAccent,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const AppBarSipenca(role: 'Petugas'),
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
                              onPressed: () {},
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
