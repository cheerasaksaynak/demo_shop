import 'package:demo_shop/widgets/login.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('ข้อมูลสมาชิก'))),
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginForm()));
              },
              child: const Text('Logout')),
        ));
  }
}
