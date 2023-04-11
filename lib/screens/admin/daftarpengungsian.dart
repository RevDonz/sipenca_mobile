import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String title;

  DetailScreen({required this.title});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<Map<String, dynamic>> _items = [
    {'title': 'Pengungsian Ibu Marni', 'description': 'Jl. Sukabirus No. 10'},
    {'title': 'Pengungsian Pak Damar', 'description': 'Jl. Sukapura No. 24'},
    {'title': 'Pengungsian Rt 04', 'description': 'PGA No. 15'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Daftar Pengungsian'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(_items[index]);
        },
      ),
    );
  }

  Widget _buildItem(Map<String, dynamic> item) {
    String title = item['title'];
    String description = item['description'];
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(215, 62, 68, 184),
            ),
          ),
          SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.check, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    _items.remove(item);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Pengungsian Telah Diterima'),
                    duration: const Duration(seconds: 2),
                  ));
                },
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _items.remove(item);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Pengungsian Telah Ditolak'),
                    duration: const Duration(seconds: 2),
                  ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
