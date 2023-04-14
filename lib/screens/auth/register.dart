import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.all(40.0),
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Buat',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Akun Anda',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30),
                    SvgPicture.asset(
                      'assets/registerlogo.svg',
                      height: 180,
                      width: 180,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(17)),
                      ),
                    ),
                    SizedBox(height: 20),
                    // TextFormField(
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(Icons.people),
                    //     hintText: 'Role',
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(17)),
                    //   ),
                    // ),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.people),
                        hintText: 'Role',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Warga',
                          child: Text('Warga'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Pengelola',
                          child: Text('Pengelola'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Sukarelawan',
                          child: Text('Sukarelawan'),
                        ),
                      ],
                      onChanged: (String? value) {
                        // handling saat dropdown dipilih
                      },
                      value: null, // value harus diatur sebagai nullable
                    ),

                    SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff51557E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ) //set warna background button
                            ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah punya akun? ',
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke halaman registrasi
                          },
                          child: InkWell(
                            onTap: () =>
                                {Navigator.pushNamed(context, "/login")},
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xff51557E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
