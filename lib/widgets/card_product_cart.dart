import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_shop/models/cart_list.dart';
import 'package:demo_shop/models/product.dart';
import 'package:demo_shop/widgets/product_detail.dart';

class CardProductCart extends StatefulWidget {
  final Product product;

  const CardProductCart({super.key, required this.product});

  @override
  State<CardProductCart> createState() => _CardProductState();
}

class _CardProductState extends State<CardProductCart> {
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
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              context.read<CartList>().remove(widget.product);
            },
          ),
        ),
      ),
    );
  }
}
