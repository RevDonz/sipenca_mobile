import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';

import '../../firebase/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  @override
  void initState() {
    // checkLogin();
  }

  void checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLogin = prefs.getBool('isLogin');
    Map<String, dynamic>? profile = jsonDecode(prefs.getString('ProfileUser')!);

    // ignore: use_build_context_synchronously
    isLogin! ? Navigator.pushNamed(context, "/${profile!['role']}") : '';
  }

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  Future<void> _showSuccessLogin(Map<String, dynamic>? user) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: const [
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                  "Berhasil !",
                  style: TextStyle(color: Colors.green, fontSize: 20),
                ),
                Text(
                  "Anda berhasil masuk",
                  style: TextStyle(color: Color(0xFF5C5C5C), fontSize: 18),
                )
              ],
            ),
          ),
          actionsPadding: EdgeInsets.only(bottom: 20),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  // print(user);
                  if (user!['role'] == 'warga') {
                    Navigator.pushNamed(context, "/warga");
                  } else if (user['role'] == 'petugas') {
                    Navigator.pushNamed(context, "/petugas", arguments: user);
                  } else if (user['role'] == 'admin') {
                    Navigator.pushNamed(context, "/admin");
                  }
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.indigoAccent,
                ),
                child: const Text(
                  "Ok",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _showFailedLogin() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Column(
              children: const [
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.red,
                  size: 50,
                ),
                SizedBox(height: 10),
                Text(
                  "Gagal !",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
                Text(
                  "Anda gagal masuk",
                  style: TextStyle(color: Color(0xFF5C5C5C), fontSize: 18),
                )
              ],
            ),
          ),
          actionsPadding: EdgeInsets.only(bottom: 20),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context, "");
                  _emailController.clear();
                  _passwordController.clear();
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.indigoAccent,
                ),
                child: const Text(
                  "Ok",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _signIn() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    User? user = await AuthService.signIn(
        _emailController.text, _passwordController.text);
    if (user != null) {
      String userId = AuthService.getCurrentUserID();
      Map<String, dynamic>? userData =
          await DatabaseService.getDetailUsers(userId);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('ProfileUser', jsonEncode(userData));
      prefs.setBool('isLogin', true);
      _showSuccessLogin(userData);
    } else {
      // User gagal login
      _showFailedLogin();
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Page',
        home: Scaffold(
            body: SafeArea(
                child: Center(
          child: SingleChildScrollView(
              child: Container(
            padding:
                const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
            margin: const EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: const [
                  Text(
                    'Masuk ke ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: const [
                  Text(
                    'Akun Anda',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 30)),
              Column(children: [
                SvgPicture.asset(
                  'assets/registerlogo.svg',
                  height: 180,
                  width: 160,
                ),
              ]),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Padding(padding: EdgeInsets.only(top: 50)),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: _toggleObscure,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Kata Sandi',
                  ),
                  obscureText: _isObscured,
                ),
              ]),
              const Padding(padding: EdgeInsets.only(top: 30)),
              const SizedBox(height: 10.0),
              Column(
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                      ),
                      Text('Ingat Saya'),
                    ],
                  ),
                  SizedBox(
                      width: 700, // ukuran lebar button
                      height: 50,
                      // ukuran tinggi button
                      child: ElevatedButton(
                        onPressed: () {
                          _signIn();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Belum punya akun? ',
                        style: TextStyle(color: Color(0xff254A75)),
                      ),
                      GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman registrasi
                          },
                          child: InkWell(
                            onTap: () =>
                                {Navigator.pushNamed(context, "/register")},
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ]),
          )),
        ))));
  }
}
