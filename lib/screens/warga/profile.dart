import 'package:flutter/material.dart';

Map<String, dynamic> profile = {
  "nik": 123456789,
  "nama": "Zahrandi Rusrizal",
  "jenisKelamin": "Pria",
  "alamat": "Bandung",
  "nomorTelepon": 08123456789,
  "tanggalLahir": "2002-02-22"
};

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

TextEditingController nikController = TextEditingController();
TextEditingController nikUpdateController = TextEditingController();

TextEditingController namaController = TextEditingController();
TextEditingController namaUpdateController = TextEditingController();

TextEditingController jenisKelaminController = TextEditingController();
TextEditingController jenisKelaminUpdateController = TextEditingController();

TextEditingController tanggalLahirController = TextEditingController();
TextEditingController tanggalLahirUpdateController = TextEditingController();

TextEditingController alamatController = TextEditingController();
TextEditingController alamatUpdateController = TextEditingController();

TextEditingController nomorTeleponController = TextEditingController();
TextEditingController nomorTeleponUpdateController = TextEditingController();

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Profile Page",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: SafeArea(
                        child: Text(
                      "NIK",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ))),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: nikController..text = profile["nik"].toString(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: SafeArea(
                        child: Text(
                      "Nama",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ))),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: namaController..text = profile["nama"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: SafeArea(
                        child: Text(
                      "Jenis Kelamin",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ))),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: jenisKelaminController
                      ..text = profile["jenisKelamin"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Text(
                      "Alamat",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: alamatController..text = profile["alamat"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Text(
                      "Nomor Telepon",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: nomorTeleponController
                      ..text = profile["nomorTelepon"].toString(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Text(
                      "Tanggal Lahir",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    enabled: false,
                    controller: tanggalLahirController
                      ..text = profile["tanggalLahir"],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ElevatedButton(
                        onPressed: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Update Data'),
                              content: Builder(
                                builder: (context) {
                                  var height = MediaQuery.of(context).size.height;
                                  var width = MediaQuery.of(context).size.width;
                                  return Container(
                                    height: height - 200,
                                    width: width - 200,
                                    child: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextField(
                                              controller: nikUpdateController
                                                ..text = profile["nik"].toString(),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'NIK',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextField(
                                              controller: namaUpdateController
                                                ..text = profile["nama"],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Nama',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(vertical: 10),
                                            child: DropdownMenu<String>(
                                              dropdownMenuEntries: const [
                                                DropdownMenuEntry(value: "Laki - laki", label: "Laki - laki"),
                                                DropdownMenuEntry(value: "Perempuan", label: "Perempuan"),
                                              ],
                                              label: const Text("Jenis Kelamin"),
                                              onSelected: (value) {
                                                jenisKelaminUpdateController.text = value!;
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextField(
                                              keyboardType: TextInputType.multiline,
                                              maxLines: null,
                                              controller: alamatUpdateController
                                                ..text = profile["alamat"],
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Alamat',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextField(
                                              controller: nomorTeleponUpdateController
                                                ..text = profile["nomorTelepon"]
                                                    .toString(),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Nomor Telepon',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: TextField(
                                              controller: tanggalLahirUpdateController
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
                                  );
                                }
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Tutup'),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    setState(() {
                                      profile = {
                                        "nik": nikUpdateController.text,
                                        "nama": namaUpdateController.text,
                                        "jenisKelamin":
                                            jenisKelaminUpdateController.text,
                                        "alamat": alamatUpdateController.text,
                                        "nomorTelepon":
                                            nomorTeleponUpdateController.text,
                                        "tanggalLahir":
                                            tanggalLahirUpdateController.text
                                      };
                                    }),
                                    Navigator.pop(context, 'OK')
                                  },
                                  child: const Text('Update'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text("Edit")),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
