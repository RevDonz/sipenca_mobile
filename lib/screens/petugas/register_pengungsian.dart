import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterPengungsian extends StatelessWidget {
  const RegisterPengungsian({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
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
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ]),
        ),
      )),
    );
  }
}
