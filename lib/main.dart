import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sipenca_mobile/firebase_options.dart';
import 'package:sipenca_mobile/screens/admin/admin.dart';
import 'package:sipenca_mobile/screens/auth/login.dart';
import 'package:sipenca_mobile/screens/auth/register.dart';
import 'package:sipenca_mobile/screens/petugas/petugas.dart';
import 'package:sipenca_mobile/screens/warga/warga.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
      home: const LoginPage(),
      routes: <String, WidgetBuilder>{
        '/warga': (context) => const MyHomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/petugas': (context) => const ListPengungsi(),
        '/admin': (context) => const AdminPage(),
      },
    );
  }
}
