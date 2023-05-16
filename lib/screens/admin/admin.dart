import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';
import 'package:sipenca_mobile/firebase/auth.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Map<String, dynamic>? profileUser;
  List<Map<String, dynamic>> listPetugas = [];
  List<Map<String, dynamic>> listPengungsian = [];
  bool isLoading = true;

  void getProfile() async {
    Map<String, dynamic>? userData =
        await DatabaseService.getDetailUsers(AuthService.getCurrentUserID());
    setState(() {
      profileUser = userData;
      isLoading = false;
    });
  }

  void getListPetugas() async {
    List<Map<String, dynamic>> list = await DatabaseService.getAllPetugas();

    setState(() {
      listPetugas = list;
      isLoading = false;
    });
  }

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
    getProfile();
    getListPetugas();
    getListPengungsian();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      AppBarSipenca(role: profileUser!['full_name']),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
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
                                        SizedBox(
                                          height: 75,
                                          width: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(20)),
                                            child: Image.network(
                                              "https://picsum.photos/id/${index + 1 * Random().nextInt(100)}/100/75",
                                            ),
                                          ),
                                        ),
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
                                                    ['rescueData']['verified']
                                                ? 'true'
                                                : 'false'),
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
                                      },
                                      backgroundColor: Colors.indigoAccent,
                                      elevation: 5,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: const Icon(Icons.check),
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
