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
  bool isLoading = true;

  void getProfile() async {
    Map<String, dynamic>? userData =
        await DatabaseService.getDetailUsers(AuthService.getCurrentUserID());
    setState(() {
      profileUser = userData;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [AppBarSipenca(role: profileUser!['full_name'])],
                  )),
            ),
    );
  }
}
