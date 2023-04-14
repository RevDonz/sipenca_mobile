//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sipenca_mobile/screens/Auth/login.dart';

class KeluargaPage extends StatefulWidget {
  const KeluargaPage({super.key});

  @override
  State<KeluargaPage> createState() => _KeluargaPageState();
}

class _KeluargaPageState extends State<KeluargaPage> {
  List<Map<String, dynamic>> DataPengungsian = [
    {"nama": "Nopal", "nik": "1302200022", "tanggal": "29/01/2002"},
    {"nama": "Doni", "nik": "112334567", "tanggal": "08/04/2002"},
    {"nama": "Zahrandi", "nik": "1302204080", "tanggal": "03/04/2002"},
    {"nama": "NPC1", "nik": "13456789", "tanggal": "08/04/2002"},
    {"nama": "NPC2", "nik": "112334567", "tanggal": "08/04/2002"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              const NetworkImage("https://picsum.photos/200"),
                          backgroundColor: Colors.grey.shade100,
                          radius: 25,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selamat Siang !",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                            const Text(
                              "Pengungsi",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          iconSize: 30,
                          splashRadius: 25,
                          onPressed: () {},
                          icon: const Icon(
                              // Icons.notifications_none_rounded,
                              Icons.notifications_none_rounded),
                        ),
                        IconButton(
                          iconSize: 30,
                          splashRadius: 25,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute<void>(
                              builder: (BuildContext context) {
                                return const LoginPage();
                              },
                            ));
                          },
                          icon: const Icon(
                              // Icons.notifications_none_rounded,
                              Icons.login),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: DataPengungsian.length,
                  itemBuilder: (BuildContext context, int index) {
                    final member = DataPengungsian[index];
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        setState(() {
                          DataPengungsian.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Data keluarga telah dihapus"),
                        ));
                      },
                      child: ListTile(
                        title: Text(member["nama"] ?? 'unknown'),
                        subtitle: Text(
                            'NIK: ${member['nik']}, TTL: ${member['tanggal']}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Hapus Data Keluarga"),
                                  content: Text(
                                      "Anda yakin ingin menghapus data keluarga ini?"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Tidak"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          DataPengungsian.removeAt(index);
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Data keluarga telah dihapus"),
                                        ));
                                        Navigator.pop(context);
                                      },
                                      child: Text("Ya"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                //Text('Ini Data keluarga yang belom dibuat'),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addMember(
              context); // Add your logic here to handle the click event of the FloatingActionButton
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addMember(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final occupationController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Data Keluarga'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'NIK',
                ),
              ),
              TextField(
                controller: occupationController,
                decoration: InputDecoration(
                  labelText: 'TTL',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final nama = nameController.text;
                final nik = ageController.text;
                final tanggal = occupationController.text;
                setState(() {
                  DataPengungsian.add({
                    'nama': nama,
                    'nik': nik,
                    'tanggal': tanggal,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
