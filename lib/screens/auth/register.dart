import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sipenca_mobile/screens/Auth/login.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
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
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.people),
                        hintText: 'Role',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: [
                        DropdownMenuItem<String>(
                          value: 'Admin',
                          child: Text('Admin'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Warga',
                          child: Text('Warga'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Petugas',
                          child: Text('Petugas'),
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          DropdownMenuItem == value;
                        });
                        // handling saat dropdown dipilih
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 700,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (DropdownMenuItem == 'Petugas') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Konfirmasi Pendaftaran'),
                                  content: Text(
                                      'Apakah anda ingin mendaftar jadi petugas? Jika iya, mohon lengkapi data yang dibutuhkan.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Lakukan pendaftaran petugas
                                      },
                                      child: Text('Daftar'),
                                    ),
                                  ],
                                );
                              },
                            );
                          } else {
                            // Lakukan pendaftaran admin atau warga
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigoAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
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
                            onTap: () => {
                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return LoginPage();
                                },
                              ))
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.indigoAccent,
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
