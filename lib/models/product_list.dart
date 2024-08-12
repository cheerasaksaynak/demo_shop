import 'package:flutter/material.dart';
import 'package:demo_shop/models/product.dart';

class ProductList with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  void add(Product model) {
    _products.add(model);
    notifyListeners();
  }

  void remove(Product model) {
    _products.remove(model);
    notifyListeners();
  }

  void setProducts(List<Product> newProducts) {
    _products = newProducts;
    notifyListeners();
  }
}
