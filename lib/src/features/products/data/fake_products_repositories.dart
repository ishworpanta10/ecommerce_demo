import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/test_products.dart';
import '../domain/product.dart';

class FakeProductRepositories {
  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    // final _product = _products.firstWhere((product) => product.id == id);
    // return Stream.value(_product);
    return watchProductsList().map(
      (products) => products.firstWhere((product) => product.id == id),
    );
  }
}

final productRepositoryProvider = Provider<FakeProductRepositories>((ref) {
  return FakeProductRepositories();
});
