import 'package:flutter/material.dart';
import 'package:sipenca_mobile/screens/auth/login.dart';
import 'package:sipenca_mobile/screens/auth/register.dart';
import 'package:sipenca_mobile/screens/petugas/petugas.dart';
import 'package:sipenca_mobile/screens/warga/warga.dart';

void main() {
  runApp(const MyApp());
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
