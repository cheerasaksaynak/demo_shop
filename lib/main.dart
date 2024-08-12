import 'package:demo_shop/widgets/home.dart';
import 'package:demo_shop/widgets/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_shop/models/cart_list.dart';
import 'package:demo_shop/models/product_list.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProductList()),
    ChangeNotifierProvider(create: (_) => CartList())
  ], child: const MainApp()));
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
      home: const HomePage(),
    );
  }
}
