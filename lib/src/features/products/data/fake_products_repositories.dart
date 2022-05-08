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

  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_products);
    // throw Exception('Connection failed');
  }

  Future<Product?> fetchProduct(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(getProductsList().firstWhere((product) => product.id == id));
  }

  // Stream<List<Product>> watchProductsList() {
  //   return Stream.value(_products);
  // }

  Stream<List<Product>> watchProductsList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    // final _product = _products.firstWhere((product) => product.id == id);
    // return Stream.value(_product);
    return watchProductsList().map(
      (products) => products.firstWhere((product) => product.id == id),
    );
  }
}

/// [FakeProductRepositories] provider for DI
final productRepositoryProvider = Provider<FakeProductRepositories>((ref) {
  return FakeProductRepositories();
});

/// [StreamProvider] to get list of Product
final productListStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.watchProductsList();
});

/// [StreamProvider] to get single product item with family modifier
final productStreamProvider = StreamProvider.family.autoDispose<Product?, String>((ref, String productId) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.watchProduct(productId);
});

/// [FutureProvider] to get list of Product
final productListFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.fetchProductsList();
});

/// [FutureProvider] to get single product item with family modifier
final productFutureProvider = FutureProvider.family.autoDispose<Product?, String>(
  (ref, String productId) {
    // debugPrint('created productProvider($productId)');
    // ref.onResume(() => debugPrint('resume productProvider($productId)'));
    // ref.onCancel(() => debugPrint('cancel productProvider($productId)'));
    // ref.onDispose(() => debugPrint('disposed productProvider($productId)'));
    final productRepository = ref.watch(productRepositoryProvider);
    return productRepository.fetchProduct(productId);
  },

  ///advance topic after riverpod 2.0
  // disposeDelay: const Duration(seconds: 10),
  // cacheTime: const Duration(seconds: 10),
);
