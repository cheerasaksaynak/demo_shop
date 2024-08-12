import 'package:demo_shop/widgets/card_product_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_shop/models/cart_list.dart';
import 'package:demo_shop/models/product.dart';

Future<List<Product>> fetchProducts(BuildContext context) async {
  return context.watch<CartList>().products;
}

class ShopingCart extends StatelessWidget {
  const ShopingCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('ตะกร้าสินค้า'))),
      body: Center(
        child: FutureBuilder(
          future: fetchProducts(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var products = (snapshot.data ?? []);
              if (products.isNotEmpty) {
                return ListView.builder(
                    itemCount: products.length,
                    prototypeItem: CardProductCart(product: products.first),
                    itemBuilder: (context, index) {
                      return CardProductCart(product: products[index]);
                    });
              } else {
                return const Text('ยังไม่มีสินค้าในตะกร้า');
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
