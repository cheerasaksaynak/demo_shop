import 'package:demo_shop/widgets/card_product_manage.dart';
import 'package:demo_shop/widgets/product_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_shop/models/product.dart';
import 'package:demo_shop/models/product_list.dart';

Future<List<Product>> fetchProducts(BuildContext context) async {
  late List<Product> products;
  var dio = Dio();
  var response = await dio
      .get('https://66801bbc56c2c76b495b2f6e.mockapi.io/online_store/products');

  if (response.statusCode == 200) {
    products = response.data.map<Product>(Product.fromJson).toList();

    //เรียงจาก id มากไปน้อย
    products.sort((a, b) =>
        double.parse(b.id.toString()).compareTo(double.parse(a.id.toString())));

    if (context.mounted) {
      context.read<ProductList>().setProducts(products);
    }
  }

  return products;
}

class ProductsManage extends StatefulWidget {
  const ProductsManage({super.key});

  @override
  State<ProductsManage> createState() => _ProductsCatalogState();
}

class _ProductsCatalogState extends State<ProductsManage> {
  void _reloadData() {
    setState(() {
      fetchProducts(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('จัดการสินค้า'))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (context) => const ProductForm()))
                            .then((value) => setState(() {}));
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("เพิ่มสินค้า")),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: fetchProducts(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var products = (snapshot.data ?? []);

                if (products.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: products.length,
                        prototypeItem: CardProductManage(
                            product: products.first, onReloadData: _reloadData),
                        itemBuilder: (context, index) {
                          return CardProductManage(
                              product: products[index],
                              onReloadData: _reloadData);
                        }),
                  );
                } else {
                  return const Text('ไม่มีรายการสินค้า');
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
