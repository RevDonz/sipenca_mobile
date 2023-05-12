import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';
import 'package:sipenca_mobile/firebase/pengungsian.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.profile, required this.listPengungsian});
  final List<Map<String, dynamic>> listPengungsian;
  final Map<String, dynamic>? profile;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Map<String, dynamic>> DataPengungsian = [];
  Map<String, dynamic>? UserProfile = {};
  bool isLoading = true;


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
                role: widget.profile!["full_name"],
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
                itemCount: widget.listPengungsian.length,
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
                                data: widget.listPengungsian[index],
                                profile: widget.profile);
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
                                  widget.listPengungsian[index]["nama"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                  "${widget.listPengungsian[index]["kapasitas_max"] - widget.listPengungsian[index]["kapasitas_terisi"]} / ${widget.listPengungsian[index]["kapasitas_max"]}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey),
                                ),
                                Text(
                                  widget.listPengungsian[index]["alamat"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            Column(children: [
                              FloatingActionButton(
                                heroTag: "btnPengungsian$index",
                                onPressed: widget.profile!['reserve'] == "" &&
                                        widget.profile!['occupied'] == ""
                                    ? () async {
                                        setState(() {
                                          UserProfile = widget.profile;
                                        });

                                        UserProfile!['reserve'] = widget
                                            .listPengungsian[index]['nama'];

                                        String userId = await DatabaseService
                                            .getDocumentIdFromQuery(
                                                'users',
                                                'full_name',
                                                UserProfile!['full_name']);

                                        DatabaseService.updateData(
                                            userId, UserProfile);
                                      }
                                    : () async {},
                                backgroundColor:
                                    widget.profile!['reserve'] == "" ||
                                            widget.profile!['reserve'] ==
                                                widget.listPengungsian[index]
                                                    ['nama']
                                        ? Colors.indigoAccent
                                        : Colors.grey,
                                elevation: 5,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: widget.profile!['reserve'] ==
                                        widget.listPengungsian[index]['nama']
                                    ? const Icon(Icons.hourglass_bottom)
                                    : const Icon(Icons.input),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "150M",
                                style: TextStyle(
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

class DetailPengungsian extends StatefulWidget {
  const DetailPengungsian({super.key, required this.data, this.profile});
  final Map<String, dynamic>? profile;
  final Map<String, dynamic> data;

  @override
  State<DetailPengungsian> createState() => _DetailPengungsianState();
}

class _DetailPengungsianState extends State<DetailPengungsian> {
  @override
  Widget build(BuildContext context) {
    // String jarak;
    // if (data["jarak"] > 1000) {
    //   jarak = "${data["jarak"] / 1000} KM";
    // } else {
    //   jarak = "${data["jarak"]} M";
    // }
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
                          Text(widget.data["nama"],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500)),
                          Text(widget.data["alamat"],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.grey)),
                        ],
                      ),
                      IconButton(
                        iconSize: 30,
                        splashRadius: 25,
                        onPressed: () {},
                        icon: widget.data["nama"] != "" &&
                                widget.data['nama'] ==
                                    widget.profile!['reserve']
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
                        label: Text("150 M")),
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
                            "${widget.data["kapasitas_max"] - widget.data["kapasitas_terisi"]} / ${widget.data["kapasitas_max"]}"))
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.data['deskripsi'],
                  ),
                ],
              )
            ],
          )),
    );
    ;
  }
}
