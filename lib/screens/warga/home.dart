import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic>? profile;
  const HomePage({super.key, required this.profile});
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> DataPengungsian = [];
  bool isLoading = true;
  bool isBooking = false;

  void getListPengungsian() async {
    List<Map<String, dynamic>> list = await DatabaseService.getAllPengungsian();
    setState(() {
      DataPengungsian = list;
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
              AppBarSipenca(
                role: isLoading ? "Loading.." : widget.profile!["full_name"],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon: const Icon(Icons.search),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    hintText: 'Cari Pengungsian',
                    hintStyle: const TextStyle(color: Colors.grey),
                    contentPadding: EdgeInsets.zero),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: DataPengungsian.length,
                itemBuilder: (context, index) {
                  // String jarak;
                  // if (DataPengungsian[index]["jarak"] > 1000) {
                  //   jarak = "${DataPengungsian[index]["jarak"] / 1000} KM";
                  // } else {
                  //   jarak = "${DataPengungsian[index]["jarak"]} M";
                  // }
                  return Card(
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: InkWell(
                      hoverColor: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return DetailPengungsian(
                                data: DataPengungsian[index]);
                          },
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Wrap(
                              spacing: 10,
                              direction: Axis.vertical,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DataPengungsian[index]["nama"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${DataPengungsian[index]["kapasitas_max"] - DataPengungsian[index]["kapasitas_terisi"]} / ${DataPengungsian[index]["kapasitas_max"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey),
                                ),
                                Text(
                                  DataPengungsian[index]["alamat"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(children: const [
                              // FloatingActionButton(
                              //   heroTag: "btnPengungsian$index",
                              //   onPressed: isBooking &&
                              //           !DataPengungsian[index]["isBooking"]
                              //       ? () {}
                              //       : () {
                              //           setState(() {
                              //             isBooking = true;
                              //             DataPengungsian[index]
                              //                 ["isBooking"] = true;
                              //           });
                              //         },
                              //   backgroundColor: isBooking &&
                              //           !DataPengungsian[index]["isBooking"]
                              //       ? Colors.grey
                              //       : Colors.indigoAccent,
                              //   elevation: 5,
                              //   shape: const RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.all(
                              //           Radius.circular(12))),
                              //   child: DataPengungsian[index]["isBooking"]
                              //       ? Icon(Icons.hourglass_bottom)
                              //       : Icon(Icons.input),
                              // ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "150M",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey),
                              )
                            ]),
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
    ));
  }
}

class DetailPengungsian extends StatelessWidget {
  const DetailPengungsian({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    String jarak;
    if (data["jarak"] > 1000) {
      jarak = "${data["jarak"] / 1000} KM";
    } else {
      jarak = "${data["jarak"]} M";
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Detail Pengungsian"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  "https://picsum.photos/500/300",
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data["nama"],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          Text(data["alamat"],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey)),
                        ],
                      ),
                      IconButton(
                        iconSize: 30,
                        splashRadius: 25,
                        onPressed: () {},
                        icon: data["isBooking"]
                            ? const Icon(
                                // Icons.notifications_none_rounded,
                                Icons.home,
                                color: Colors.indigoAccent)
                            : const Icon(
                                // Icons.notifications_none_rounded,
                                Icons.home_outlined,
                                color: Colors.indigoAccent),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(direction: Axis.horizontal, spacing: 10, children: [
                    OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.indigoAccent,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            side: const BorderSide(
                                color: Colors.indigoAccent, width: 2)),
                        icon: const Icon(Icons.pin_drop),
                        label: Text(jarak)),
                    OutlinedButton.icon(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.indigoAccent,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            side: const BorderSide(
                                color: Colors.indigoAccent, width: 2)),
                        icon: const Icon(Icons.group_outlined),
                        label: Text(
                            "${data["kapasitasTersisa"]} / ${data["kapasitas"]}"))
                  ]),
                ],
              )
            ],
          )),
    );
    ;
  }
}
