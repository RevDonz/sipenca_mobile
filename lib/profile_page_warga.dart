import 'package:flutter/material.dart';

Map<String, dynamic> profile ={
  "nik": 123456789,
  "nama": "Zahrandi Rusrizal",
  "jenisKelamin": "Pria",
  "alamat": "Bandung",
  "nomorTelepon": 08123456789,
  "tanggalLahir": "2002-02-22"
};

class ProfilePage extends StatefulWidget{
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

TextEditingController nikController = TextEditingController();
TextEditingController namaController = TextEditingController();
TextEditingController jenisKelaminController = TextEditingController();
TextEditingController tanggalLahirController = TextEditingController();
TextEditingController alamatController = TextEditingController();
TextEditingController nomorTeleponController = TextEditingController();


class ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10,),
                const Center(
                  child: Text(
                    "Profile Page",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: SafeArea(child: Text("NIK", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: nikController
                      ..text = profile["nik"].toString(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: SafeArea(child: Text("Nama", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: namaController
                      ..text = profile["nama"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: SafeArea(child: Text("Jenis Kelamin", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),))),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: jenisKelaminController
                      ..text = profile["jenisKelamin"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Text("Alamat", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: alamatController
                      ..text = profile["alamat"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Text("Nomor Telepon", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: nomorTeleponController
                      ..text = profile["nomorTelepon"].toString(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Text("Tanggal Lahir", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: tanggalLahirController
                      ..text = profile["tanggalLahir"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Update Data'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: nikController
                                  ..text = profile["nik"].toString(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'NIK',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: namaController
                                  ..text = profile["nama"],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nama',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: jenisKelaminController
                                  ..text = profile["jenisKelamin"],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Jenis Kelamin',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: alamatController
                                  ..text = profile["alamat"],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Alamat',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: nomorTeleponController
                                  ..text = profile["nomorTelepon"].toString(),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Nomor Telepon',
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: tanggalLahirController
                                  ..text = profile["tanggalLahir"],
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Tanggal Lahir',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Tutup'),
                        ),
                        TextButton(
                          onPressed: () => {
                            setState(() {
                              profile = {
                                "nik": nikController.text,
                                "nama": namaController.text,
                                "jenisKelamin": jenisKelaminController.text,
                                "alamat": alamatController.text,
                                "nomorTelepon": nomorTeleponController.text,
                                "tanggalLahir": tanggalLahirController.text
                              };
                            }),
                            Navigator.pop(context, 'OK')
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  );
                  }, child: const Text("Edit")),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}