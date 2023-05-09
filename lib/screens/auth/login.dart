import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../firebase/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscured = true;

  void _toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  void _signIn() async {
    User? user = await AuthService.signIn(
        _emailController.text, _passwordController.text);
    if (user != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Column(
                children: [
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
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "/");
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.indigoAccent,
                  ),
                ),
              )
            ],
          );
        },
      );
    } else {
      // User gagal login
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Column(
                children: [
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
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
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
                ),
              )
            ],
          );
        },
      );
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
            padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
            margin: EdgeInsets.all(20),
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
              Padding(padding: EdgeInsets.only(top: 30)),
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
                  Container(
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
                  Padding(padding: EdgeInsets.only(top: 10)),
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
