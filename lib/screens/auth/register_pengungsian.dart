import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sipenca_mobile/firebase/auth.dart';
import 'package:sipenca_mobile/screens/petugas/petugas.dart';

class RegisterPengungsian extends StatefulWidget {
  const RegisterPengungsian(
      {super.key, required this.email, required this.password});
  final String email, password;

  @override
  State<RegisterPengungsian> createState() => _RegisterPengungsianState();
}

class _RegisterPengungsianState extends State<RegisterPengungsian> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 10),
              margin: const EdgeInsets.all(20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Daftarkan',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'Pengungsian',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
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
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 50)),
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Nama Pengungsian',
                                labelStyle: const TextStyle(fontSize: 15)),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Alamat Pengungsian',
                                labelStyle: const TextStyle(fontSize: 15)),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          TextFormField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Kapasitas Pengungsian',
                                labelStyle: const TextStyle(fontSize: 15)),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 20)),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'Deskripsi Pengungsian',
                                labelStyle: const TextStyle(fontSize: 15)),
                          ),
                        ]),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    const SizedBox(height: 10.0),
                    Column(
                      children: [
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        SizedBox(
                          width: 700, // ukuran lebar button
                          height: 50, // ukuran tinggi button
                          child: ElevatedButton(
                            onPressed: () async {
                              await AuthService.registerAccount(
                                  widget.email, widget.password, "petugas");

                              Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return const ListPengungsi();
                                },
                              ));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigoAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))
                                //set warna background button
                                ),
                            child: const Text(
                              'Daftar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            )),
          ),
        )));
  }
}
