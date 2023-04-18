import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';
import 'package:sipenca_mobile/firebase_options.dart';
import 'package:sipenca_mobile/screens/auth/login.dart';
import 'package:sipenca_mobile/screens/auth/register.dart';
import 'package:sipenca_mobile/screens/petugas/petugas.dart';
import 'package:sipenca_mobile/screens/warga/warga.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(home: const Akun()));
  // final db = DatabaseService();
  // await db.getAkun(email: "tes@gmail.com");
  // print(tes);
}

CollectionReference akun = FirebaseFirestore.instance.collection('users');
final db = DatabaseService();

class Akun extends StatelessWidget {
  const Akun({super.key});

  @override
  Widget build(BuildContext context) {
    getData();

    return FutureBuilder<DocumentSnapshot>(
        future: akun.doc("3ZU77FNJfUwfqoJeo0B4").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text("${data['email']} : ${data['username']}");
          }

          return Text("loading");
        });
  }
}

void getData() async {
  Map<String, dynamic>? userData =
      await db.getDetailUsers("3ZU77FNJfUwfqoJeo0B4");
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
      // home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/': (context) => const MyHomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/petugas': (context) => const ListPengungsi(),
      },
    );
  }
}
