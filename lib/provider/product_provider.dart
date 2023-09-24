import 'dart:math';

import 'package:flutter/material.dart';

import '../pages/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    products.add(product);
    print(products.toString());
    notifyListeners();
  }

  void updateProduct(Product product) {
    int index = products.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(Product product) {
    int index = products.indexWhere((element) => element.id == product.id);
    if (index >= 0) {
      products.removeWhere((element) => element.id == product.id);
      notifyListeners();
    }
  }

  void saveProductFromData(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
        id: hasId ? data['id'].toString() : Random().nextDouble().toString(),
        name: data['name'].toString(),
        description: data['description'].toString(),
        price: data['price'] as double,
        urlImage: data['urlImage'].toString());
    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }
}
