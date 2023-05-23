import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/appBar.dart';
import '../../firebase/pengungsian.dart';

class DetailPengungsian extends StatefulWidget {
  const DetailPengungsian({super.key, required this.profileWarga});
  final Map<String, dynamic>? profileWarga;

  @override
  State<DetailPengungsian> createState() => _DetailPengungsianState();
}

class _DetailPengungsianState extends State<DetailPengungsian> {
  TextEditingController namaController = TextEditingController();
  TextEditingController kapasitasController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Map<String, dynamic>? dataPengungsi = {};
  Map<String, dynamic>? dataPengungsiBaru = {};
  bool isLoading = true;

  void getDataPengungsian() async {
    Map<String, dynamic>? data = await DatabaseService.getPengungsianById(
        widget.profileWarga!['pengungsian']);

    setState(() {
      dataPengungsi = data;
      dataPengungsiBaru = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataPengungsian();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const AppBarSipenca(role: "Petugas"),
              const SizedBox(height: 10),
              const TabBar(
                indicatorColor: Colors.indigoAccent,
                labelColor: Colors.indigoAccent,
                unselectedLabelColor: Colors.grey,
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                tabs: <Widget>[
                  Tab(
                    text: "Detail Pengungsian",
                  ),
                  Tab(
                    text: "Kebutuhan",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image.network(
                                      "https://picsum.photos/id/${Random().nextInt(100)}/500/300",
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(dataPengungsi!["nama"],
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              Text(dataPengungsi!["alamat"],
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.grey)),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        AlertDialog(
                                                  title: const Text(
                                                      'Edit Pengungsian'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: ListBody(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: TextField(
                                                            controller: namaController
                                                              ..text =
                                                                  dataPengungsi![
                                                                      'nama'],
                                                            decoration:
                                                                InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              labelText:
                                                                  'Nama Pengungsian',
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: TextField(
                                                            controller: kapasitasController
                                                              ..text = dataPengungsi![
                                                                      'kapasitas_max']
                                                                  .toString(),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            inputFormatters: [
                                                              FilteringTextInputFormatter
                                                                  .digitsOnly,
                                                            ],
                                                            decoration:
                                                                InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              labelText:
                                                                  'Kapasitas maksimal',
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          child: TextField(
                                                            controller: descController
                                                              ..text = dataPengungsi![
                                                                      'deskripsi']
                                                                  .toString(),
                                                                  keyboardType:
                                                                TextInputType
                                                                    .multiline,
                                                            maxLines: null,
                                                            decoration:
                                                                InputDecoration(
                                                              border: OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                              labelText:
                                                                  'Deskripsi Pengungsian',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(context,
                                                              'Cancel'),
                                                      child:
                                                          const Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () async {
                                                        Navigator.pop(
                                                            context, 'OK');
                                                        dataPengungsiBaru![
                                                                'nama'] =
                                                            namaController.text;
                                                        dataPengungsiBaru![
                                                                'kapasitas_max'] =
                                                            int.parse(
                                                                kapasitasController
                                                                    .text);
                                                        dataPengungsiBaru![
                                                                'deskripsi'] =
                                                            descController.text;
                                                        await DatabaseService
                                                                .updatePengungsian(
                                                                    widget.profileWarga![
                                                                        'pengungsian'],
                                                                    dataPengungsiBaru)
                                                            .then((value) => {
                                                                  getDataPengungsian()
                                                                });
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            icon:
                                                const Icon(Icons.edit_document),
                                            color: Colors.indigoAccent,
                                            splashRadius: 25,
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Wrap(
                                          direction: Axis.horizontal,
                                          spacing: 10,
                                          children: [
                                            OutlinedButton.icon(
                                                onPressed: () {},
                                                style: OutlinedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.indigoAccent,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50)),
                                                    side: const BorderSide(
                                                        color:
                                                            Colors.indigoAccent,
                                                        width: 2)),
                                                icon: const Icon(
                                                    Icons.group_outlined),
                                                label: Text(
                                                    "${dataPengungsi!["kapasitas_max"] - dataPengungsi!["kapasitas_terisi"]} / ${dataPengungsi!["kapasitas_max"]}"))
                                          ]),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Description",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        dataPengungsi!['deskripsi'],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                    Center(
                      child: Text("Kedua"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
