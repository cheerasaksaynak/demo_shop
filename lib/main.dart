import 'package:demo_shop/widgets/home.dart';
import 'package:demo_shop/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_shop/models/cart_list.dart';
import 'package:demo_shop/models/product_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductList()),
    ChangeNotifierProvider(create: (_) => CartList())
  ], child: const MainApp()));
}

Future<String> getAccessToken(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('access_token') ?? '';
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder(
          future: getAccessToken(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching access token'),
              );
            } else {
              var accessToken = (snapshot.data ?? '');
              if (accessToken.isNotEmpty) {
                return const HomePage();
              } else {
                return const LoginForm();
              }
            }
          }),
    );
  }
}
