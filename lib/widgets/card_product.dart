import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_shop/models/cart_list.dart';
import 'package:demo_shop/models/product.dart';
import 'package:demo_shop/widgets/product_detail.dart';

class CardProduct extends StatefulWidget {
  final Product product;

  const CardProduct({super.key, required this.product});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProductDetail(product: widget.product)))
            .then((value) => setState(() {}))
      },
      child: Card(
        child: ListTile(
          leading: Image(image: NetworkImage(widget.product.imageUrl ?? '')),
          title: Text(widget.product.name ?? ''),
          subtitle: Text(widget.product.price ?? ''),
          trailing: TextButton(
            child:
                //ตรวจสอบว่ามีใน cart หรือยังและแสดง icon
                context.read<CartList>().products.contains(widget.product)
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.add_shopping_cart,
                        color: Colors.blue,
                      ),
            onPressed: () {
              //ตรวจสอบว่ามีใน cart หรือยังก่อนเพิ่ม
              if (!context.read<CartList>().products.contains(widget.product)) {
                context.read<CartList>().add(widget.product);
                setState(() {});
              }
            },
          ),
        ),
      ),
    );
  }
}
