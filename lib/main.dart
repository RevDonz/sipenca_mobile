import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';
import 'package:sipenca_mobile/firebase_options.dart';
import 'package:sipenca_mobile/screens/admin/daftarpengungsian.dart';
import 'package:sipenca_mobile/screens/auth/login.dart';
import 'package:sipenca_mobile/screens/auth/register.dart';
import 'package:sipenca_mobile/screens/petugas/petugas.dart';
import 'package:sipenca_mobile/screens/warga/warga.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(MaterialApp(home: DetailScreen(title: "Halaman admin")));
  // List<Map<String, dynamic>> list =
  //     await DatabaseService.getPengungsiOnPengungsian('AXUj1TS3rnLlBuob6Ud2');
  // list.forEach((element) => print(element['full_name']));
  runApp(const MyApp());
}

CollectionReference akun = FirebaseFirestore.instance.collection('users');

class Akun extends StatefulWidget {
  const Akun({super.key});

  @override
  State<Akun> createState() => _AkunState();
}

class _AkunState extends State<Akun> {
  List<Map<String, dynamic>> usersList = [];

  void getUserList() async {
    List<Map<String, dynamic>> list = await DatabaseService.getAllUsers();
    setState(() {
      usersList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserList();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Users'),
      ),
      body: ListView.builder(
        itemCount: usersList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(usersList[index]['username']),
            subtitle: Text(usersList[index]['email']),
          );
        },
      ),
    );
  }
}

void getData() async {
  Map<String, dynamic>? userData =
      await DatabaseService.getDetailUsers("3ZU77FNJfUwfqoJeo0B4");
  // List<Map<String, dynamic>?> userData = await db.getAllUsers();

  print(userData);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: "Poppins"),
      home: const ListPengungsi(),
      // routes: <String, WidgetBuilder>{
      //   '/': (context) => const MyHomePage(),
      //   '/login': (context) => const LoginPage(),
      //   '/register': (context) => const RegisterPage(),
      //   '/petugas': (context) => const ListPengungsi(),
      // },
    );
  }
}
