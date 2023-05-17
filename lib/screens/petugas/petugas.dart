import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';
import 'package:sipenca_mobile/firebase/auth.dart';
import 'package:sipenca_mobile/screens/warga/profile.dart';
import 'package:sipenca_mobile/screens/petugas/accWarga.dart';

class ListPengungsi extends StatefulWidget {
  const ListPengungsi({super.key});

  @override
  State<ListPengungsi> createState() => _ListPengungsiState();
}

class _ListPengungsiState extends State<ListPengungsi> {
  List<Map<String, dynamic>> dataPengungsi = [];
  Map<String, dynamic>? profilePetugas;
  Map<String, dynamic>? user;
  int _selectedIndex = 0;

  // void getListPengungsi() async {
  //   List<Map<String, dynamic>> list =
  //       await DatabaseService.getPengungsiOnPengungsian('AXUj1TS3rnLlBuob6Ud2');

  //   setState(() {
  //     dataPengungsi = list;
  //   });
  // }

  void getProfile() async {
    Map<String, dynamic>? userData =
        await DatabaseService.getDetailUsers(AuthService.getCurrentUserID());

    setState(() {
      profilePetugas = userData;
    });
  }

  void checkProfile() async {
    Map<String, dynamic>? userData =
        await DatabaseService.getDetailUsers(AuthService.getCurrentUserID());

    if (userData!['full_name'] == "" ||
        userData['nik'] == "" ||
        userData['no_hp'] == "" ||
        userData['jenis_kelamin'] == "" ||
        userData['tgl_lahir'] == "" ||
        userData['alamat'] == "") {
      setState(() {
        _selectedIndex = 2;
      });
    }
  }
  // List<Map<String, dynamic>> dataPengungsi = [
  //   {"nama": "Rama", "member": 4, "alamat": "Kampung A", "jarak": 500},
  //   {"nama": "Doni", "member": 2, "alamat": "Kampung B", "jarak": 1000},
  //   {"nama": "Nopal", "member": 3, "alamat": "Kampung C", "jarak": 1500},
  // ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void getListPengungsi() async {
    List<Map<String, dynamic>> list = [];
    QuerySnapshot<Map<String, dynamic>> snap = await FirebaseFirestore.instance
        .collection('users')
        .where('reserve', isEqualTo: 'HJ9UI8nZnWCsToXiwtsz')
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
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   setState(() {
    //     user =
    //         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    //   });
    // });
    getProfile();
    getListPengungsi();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      accWarga(listWarga: dataPengungsi),
      const Text(
        'Index 2: School',
        style: optionStyle,
      ),
      ProfilePage(profileWarga: profilePetugas),
    ];

    return Scaffold(
      body: Center(child: widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: profilePetugas!['full_name'] as String,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Pengungsian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigoAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
