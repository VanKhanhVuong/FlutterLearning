import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_riverpod/models/product.dart';

class CartNotifier extends Notifier<Set<Product>> {
  // Init values
  @override
  Set<Product> build() {
    return const {
      Product(
          id: '4',
          title: 'Red Backpack',
          price: 14,
          image: 'assets/products/backpack.png'),
    };
  }

  // Method to update state
}

final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
  return CartNotifier();
});
