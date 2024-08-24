import 'package:demo_shop/models/person.dart';
import 'package:demo_shop/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Person> getProfile() async {
  final db = FirebaseFirestore.instance;

  final prefs = await SharedPreferences.getInstance();
  var userId = prefs.getString('access_token');

  var user = await db.collection("users").doc(userId).get();

  if (user.exists) {
    return Person(user.id.toString(), user.data()!["first_name"].toString(),
        user.data()!["last_name"].toString());
  }

  return Person('', '', '');
}

Future<void> removeAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
}

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Person person = Person('', '', '');

  @override
  void initState() {
    super.initState();

    getProfile().then((profile) {
      setState(() {
        person = profile;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Center(child: Text('ข้อมูลสมาชิก'))),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      person.firstName,
                      style: const TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      person.lastName,
                      style: const TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    removeAccessToken();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginForm()));
                  },
                  child: const Text('Logout')),
            ),
          ],
        ));
  }
}
