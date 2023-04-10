import 'package:flutter/material.dart';
import 'package:sipenca_mobile/screens/Auth/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> DataPengungsian = [
    {
      "nama": "Lapangan",
      "kapasitas": 100,
      "kapasitasTersisa": 50,
      "alamat": "Kampung Durian Runtuh",
      "jarak": 1500
    },
    {
      "nama": "Rumah Pak RT",
      "kapasitas": 50,
      "kapasitasTersisa": 10,
      "alamat": "Jl. in aja dulu",
      "jarak": 200
    },
    {
      "nama": "Lapangan",
      "kapasitas": 100,
      "kapasitasTersisa": 50,
      "alamat": "Kampung",
      "jarak": 300
    },
    {
      "nama": "Lapangan",
      "kapasitas": 100,
      "kapasitasTersisa": 50,
      "alamat": "Kampung",
      "jarak": 2300
    },
    {
      "nama": "Lapangan",
      "kapasitas": 100,
      "kapasitasTersisa": 50,
      "alamat": "Kampung",
      "jarak": 150
    },
    {
      "nama": "Lapangan",
      "kapasitas": 100,
      "kapasitasTersisa": 50,
      "alamat": "Kampung",
      "jarak": 150
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.grey.shade50,
        body: SafeArea(
      child: SingleChildScrollView(
        // child: Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //     colors: [
        //       Colors.grey.shade50,
        //       Colors.grey.shade100,
        //     ],
        //   )),
        //   padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        //   child: ,
        // ),
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
                shrinkWrap: true,
                itemCount: DataPengungsian.length,
                itemBuilder: (context, index) {
                  String jarak;
                  if (DataPengungsian[index]["jarak"] > 1000) {
                    jarak = "${DataPengungsian[index]["jarak"] / 1000} KM";
                  } else {
                    jarak = "${DataPengungsian[index]["jarak"]} M";
                  }
                  return GestureDetector(
                    onTap: () {
                      print("as");
                    },
                    child: (Card(
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
                                    "${DataPengungsian[index]["kapasitasTersisa"]} / ${DataPengungsian[index]["kapasitas"]}",
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
                              Column(children: [
                                FloatingActionButton(
                                  onPressed: () {},
                                  backgroundColor: Colors.indigoAccent,
                                  elevation: 5,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: const Icon(Icons.input),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  jarak,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.blueGrey),
                                )
                              ]),
                            ],
                          ),
                        ),
                      ),
                    )),
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Detail Pengungsian"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.network(
                  "https://picsum.photos/500/300",
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data["nama"]),
                  Text(data["alamat"]),
                ],
              )
            ],
          )),
    );
    ;
  }
}