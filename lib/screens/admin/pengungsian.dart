import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';

class DaftarPengungsian extends StatefulWidget {
  const DaftarPengungsian({super.key, required this.profileData});
  final Map<String, dynamic>? profileData;

  @override
  State<DaftarPengungsian> createState() => _DaftarPengungsianState();
}

class _DaftarPengungsianState extends State<DaftarPengungsian> {
  List<Map<String, dynamic>> listPengungsian = [];
  bool isLoading = true;

  void getListPengungsian() async {
    List<Map<String, dynamic>> list =
        await DatabaseService.getUnverifPengungsian();

    setState(() {
      listPengungsian = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getListPengungsian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                AppBarSipenca(role: widget.profileData!['full_name']),
                const SizedBox(
                  height: 20,
                ),
                listPengungsian.isEmpty
                    ? const Center(
                        child: Text("Tidak ada data untuk ditampilkan"))
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listPengungsian.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            child: InkWell(
                              hoverColor: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Wrap(
                                          direction: Axis.vertical,
                                          crossAxisAlignment:
                                              WrapCrossAlignment.start,
                                          alignment: WrapAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                                listPengungsian[index]
                                                    ['rescueData']['nama'],
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(listPengungsian[index]
                                                ['rescueData']['alamat']),
                                            Text(listPengungsian[index]
                                                ['email']),
                                          ],
                                        ),
                                      ],
                                    ),
                                    FloatingActionButton(
                                      heroTag: "btnPengungsian$index",
                                      onPressed: () {
                                        listPengungsian[index]['rescueData']
                                            ['verified'] = true;

                                        DatabaseService.updatePengungsian(
                                            listPengungsian[index]
                                                ['pengungsian'],
                                            listPengungsian[index]
                                                ['rescueData']);
                                        getListPengungsian();
                                      },
                                      backgroundColor: Colors.indigoAccent,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: const Icon(Icons.check),
                                    ),
                                    FloatingActionButton(
                                      heroTag: "btnPengungsian$index",
                                      onPressed: () async {
                                        String docId = await DatabaseService
                                            .getDocumentIdFromQuery(
                                                'users',
                                                'email',
                                                listPengungsian[index]
                                                    ['email']);
                                        FirebaseFirestore.instance
                                            .collection('pengungsians')
                                            .doc(listPengungsian[index]
                                                ['pengungsian'])
                                            .delete();

                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(docId)
                                            .delete();

                                        getListPengungsian();
                                      },
                                      backgroundColor: Colors.red,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: const Icon(Icons.cancel),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
