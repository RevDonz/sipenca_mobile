import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sipenca_mobile/firebase/auth.dart';
import 'package:sipenca_mobile/screens/auth/register_pengungsian.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  String selectedRole = "";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  Future<void> _register() async {
    setState(() {
      isLoading = true;
    });
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      // If the user was successfully created
      if (userCredential.user != null) {
        // Add the user's role to the user's custom claims
        //await userCredential.user!.setCustomClaims({'role': selectedRole});
        // Redirect the user to the next page after successful registration
        Navigator.pushReplacementNamed(context, '/next-page');
      }
    } catch (e) {
      // Handle registration errors
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _showSuccessRegisterwarga(String email, String password) async {
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
                  "Anda berhasil daftar",
                  style: TextStyle(color: Color(0xFF5C5C5C), fontSize: 18),
                )
              ],
            ),
          ),
          actionsPadding: EdgeInsets.only(bottom: 20),
          actions: [
            Center(
              child: TextButton(
                onPressed: () async {
                  // print(user);
                  Navigator.pushNamed(context, "/login");
                  await AuthService.registerAccount(
                      email, password, 'warga', '');
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(40.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: const [
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
                          children: const [
                            Text(
                              'Akun Anda',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                        SvgPicture.asset(
                          'assets/registerlogo.svg',
                          height: 180,
                          width: 180,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Kata Sandi',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.people),
                            hintText: 'Role',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          items: const [
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
                              selectedRole = value!;
                            });

                            // handling saat dropdown dipilih
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 700,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: selectedRole == "Petugas"
                                ? () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Konfirmasi Pendaftaran Pengungsian'),
                                          content: const Text(
                                              'Informasi pengungsian diperlukan untuk pendaftaran'),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Batal'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // Lakukan pendaftaran petugas
                                                // final SharedPreferences prefs =
                                                //     await SharedPreferences
                                                //         .getInstance();

                                                // await prefs.setString('email',
                                                //     emailController.text);

                                                String email =
                                                    emailController.text.trim();
                                                String password =
                                                    passwordController.text
                                                        .trim();
                                                Navigator.push(context,
                                                    MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) {
                                                    return RegisterPengungsian(
                                                        email: email,
                                                        password: password);
                                                  },
                                                ));
                                              },
                                              child: const Text('Daftar'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                : () async {
                                    // Navigator.pushNamed(context, "/login");
                                    String email = emailController.text.trim();
                                    String password =
                                        passwordController.text.trim();

                                    // await AuthService.registerAccount(
                                    //     email, password, 'warga', '');
                                    _showSuccessRegisterwarga(email, password);
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                  'Masuk',
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
        ));
  }
}
