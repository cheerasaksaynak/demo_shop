import 'package:demo_shop/widgets/products_catalog.dart';
import 'package:demo_shop/widgets/products_manage.dart';
import 'package:demo_shop/widgets/profile.dart';
import 'package:demo_shop/widgets/shoping_cart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            ProductsCatalog(),
            ShopingCart(),
            ProductsManage(),
            Profile(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.list), text: "Catalog"),
            Tab(icon: Icon(Icons.shopping_cart), text: "Cart"),
            Tab(icon: Icon(Icons.edit_note), text: "Manage"),
            Tab(icon: Icon(Icons.person), text: "Profile"),
          ],
        ),
      ),
    );
  }
}
