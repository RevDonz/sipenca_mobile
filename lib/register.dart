import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.all(40.0),
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
                  height: 160,
                  width: 160,
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
                Container(
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
                        onTap: () => _launchURL,
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
    );
  }
}

class _launchURL {}
