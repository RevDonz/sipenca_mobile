import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';
import 'package:sipenca_mobile/firebase/auth.dart';
import 'package:sipenca_mobile/screens/warga/profile.dart';


class accWarga extends StatefulWidget {
  final List<Map<String, dynamic>> listWarga;
  const accWarga({super.key, required this.listWarga});

  @override
  State<accWarga> createState() => _accWargaState();
}

class _accWargaState extends State<accWarga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const AppBarSipenca(role: "Petugas"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text('Pengungsi yang datang')],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.listWarga.length,
              itemBuilder: (context, index) {
                // String jarak;
                // if (dataPengungsi[index]["jarak"] >= 1000) {
                //   jarak = "${dataPengungsi[index]["jarak"] / 1000} KM";
                // } else {
                //   jarak = "${dataPengungsi[index]["jarak"]} M";
                // }
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.listWarga[index]['full_name']),
                                // Text(jarak),
                                // Text("${dataPengungsi[index]['member']}orang"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(widget.listWarga[index]['alamat']),
                            ),
                            FloatingActionButton(
                              heroTag: "btnPengungsi$index",
                              onPressed: () {},
                              backgroundColor: Colors.indigoAccent,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: const Icon(Icons.input),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ]),
        ),
      )),
    );
  }

}
