import 'package:demo_shop/widgets/product_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:demo_shop/models/product.dart';

Future<bool> deleteProduct(BuildContext context, Product product) async {
  var dio = Dio();
  var id = product.id;
  var response = await dio.delete(
      'https://66801bbc56c2c76b495b2f6e.mockapi.io/online_store/products/$id');

  return response.statusCode == 200;
}

class CardProductManage extends StatefulWidget {
  final Product product;

  final VoidCallback onReloadData;

  const CardProductManage(
      {super.key, required this.product, required this.onReloadData});

  @override
  State<CardProductManage> createState() => _CardProductState();
}

class _CardProductState extends State<CardProductManage> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image(image: NetworkImage(widget.product.imageUrl ?? '')),
        title: Text(widget.product.name ?? ''),
        subtitle: Text(widget.product.price ?? ''),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
              onPressed: () {
                //เปิดฟอร์มเพื่อแก้ไข
                Navigator.of(context)
                    .push(MaterialPageRoute(
                        builder: (context) =>
                            ProductForm(product: widget.product)))
                    .then((value) => widget.onReloadData());
              },
            ),
            TextButton(
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                deleteProduct(context, widget.product);
                widget.onReloadData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
