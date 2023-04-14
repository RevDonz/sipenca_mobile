import 'package:flutter/material.dart';
import 'package:sipenca_mobile/screens/Auth/login.dart';

class AppBarSipenca extends StatefulWidget {
  final String role;
  const AppBarSipenca({super.key, required this.role});

  @override
  State<AppBarSipenca> createState() => _AppBarSipencaState();
}

class _AppBarSipencaState extends State<AppBarSipenca> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
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
                  Text(
                    widget.role,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
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
    );
  }
}