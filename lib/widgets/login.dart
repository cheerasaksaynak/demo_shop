import 'package:demo_shop/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> authenWithFirestore(String username, String password) async {
  final db = FirebaseFirestore.instance;

  var users = await db
      .collection("users")
      .where("username", isEqualTo: username)
      .where("password", isEqualTo: password)
      .limit(1)
      .get();

  if (users.docs.isNotEmpty) {
    //store token in local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', users.docs[0].id);

    return true;
  }

  return false;
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  var authResult = '';
  var username = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Demo Shop'))),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Username'),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  obscureText: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    username = value;
                    return null;
                  },
                ),
              ),
              const Text('Password'),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    password = value;
                    return null;
                  },
                ),
              ),
              Center(
                child: Text(
                  authResult,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authenWithFirestore(username, password)
                              .then((result) {
                            if (result == true) {
                              authResult = '';
                              // Authentication successful
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            } else {
                              // Authentication failed
                              setState(() => authResult =
                                  "ยืนยันตัวตนไม่สำเร็จโปรดลองใหม่อีกครั้ง");
                            }
                          });
                        }
                      },
                      child: const Text('Login'))),
            ],
          ),
        ),
      ),
    );
  }
}
