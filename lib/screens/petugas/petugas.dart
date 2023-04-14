import 'package:flutter/material.dart';
import 'package:sipenca_mobile/components/appBar.dart';

class ListPengungsi extends StatefulWidget {
  const ListPengungsi({super.key});

  @override
  State<ListPengungsi> createState() => _ListPengungsiState();
}

class _ListPengungsiState extends State<ListPengungsi> {
  List<Map<String, dynamic>> dataPengungsi = [
    {"nama": "Rama", "member": 4, "alamat": "Kampung A", "jarak": 500},
    {"nama": "Doni", "member": 2, "alamat": "Kampung B", "jarak": 1000},
    {"nama": "Nopal", "member": 3, "alamat": "Kampung C", "jarak": 1500},
  ];

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Scaffold(),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Scaffold(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Warga',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Pengungsian',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigoAccent,
        onTap: _onItemTapped,
      ),
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
              itemCount: dataPengungsi.length,
              itemBuilder: (context, index) {
                String jarak;
                if (dataPengungsi[index]["jarak"] >= 1000) {
                  jarak = "${dataPengungsi[index]["jarak"] / 1000} KM";
                } else {
                  jarak = "${dataPengungsi[index]["jarak"]} M";
                }
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
                                Text(dataPengungsi[index]['nama']),
                                Text(jarak),
                                Text("${dataPengungsi[index]['member']}orang"),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(dataPengungsi[index]['alamat']),
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
