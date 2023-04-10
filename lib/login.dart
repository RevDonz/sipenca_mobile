import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _rememberMe = false;

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login Page',
        home: Scaffold(
            body: Center(
          child: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
            margin: EdgeInsets.all(20),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                children: [
                  Text(
                    'Login ke ',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
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
                  //tambahkan icon email disini
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Email'),

                  keyboardType: TextInputType.emailAddress,
                ),
                const Padding(padding: EdgeInsets.only(top: 20)),
                TextFormField(
                  //tambahkan icon kunci disini
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Password'),
                  obscureText: true,
                ),
              ]),
              const Padding(padding: EdgeInsets.only(top: 30)),
              SizedBox(height: 10.0),
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
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Container(
                    width: 400, // ukuran lebar button
                    height: 50, // ukuran tinggi button
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF51557E),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))
                          //set warna background button
                          ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
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
                            onTap: () => _launchURL,
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Color(0xff254A75),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ]),
          )),
        )));
  }
}

class _launchURL {}
