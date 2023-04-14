//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';

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
                const AppBarSipenca(
                  role: "Pengungsi",
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
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
                          color: Color.fromARGB(255, 244, 96, 85),
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
        backgroundColor: Colors.indigoAccent,
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
    final nikController = TextEditingController();
    final tanggalController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tambah Data Keluarga'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Nama'),
              ),
              SizedBox(height: 15),
              TextField(
                controller: nikController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'NIK',
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: tanggalController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'TTL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final nama = nameController.text;
                final nik = nikController.text;
                final tanggal = tanggalController.text;
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
