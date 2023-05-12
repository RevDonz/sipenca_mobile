import 'package:flutter/material.dart';
import 'package:sipenca_mobile/firebase/auth.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';
import 'package:sipenca_mobile/screens/warga/home.dart';
import 'package:sipenca_mobile/screens/warga/keluarga.dart';
import 'package:sipenca_mobile/screens/warga/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> DataPengungsian = [];
  Map<String, dynamic>? profileUser;
  bool isLoading = true;
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
      profileUser = userData;
      isLoading = false;
    });
  }

  void getListPengungsian() async {
    List<Map<String, dynamic>> list = await DatabaseService.getAllPengungsian();

    setState(() {
      DataPengungsian = list;
      isLoading = false;
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

  @override
  void initState() {
    super.initState();
    getProfile();
    getListPengungsian();
    checkProfile();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      HomePage(listPengungsian: DataPengungsian, profile: profileUser),
      // HomePage(),
      KeluargaPage(),
      ProfilePage(profileWarga: profileUser),
    ];

    return Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(child: widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_outlined),
              label: 'Keluarga',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.indigoAccent,
          onTap: _onItemTapped,
        ));
  }
}
