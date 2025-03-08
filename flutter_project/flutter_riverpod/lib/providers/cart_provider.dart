import 'package:my_flutter_riverpod/models/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  // Init values
  @override
  Set<Product> build() {
    return const {};
  }

  // Method to update state
  void addToCart(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  void removeFromCart(Product product) {
    if (state.contains(product)) {
      state = state.where((p) => p.id != product.id).toSet();
    }
  }
}
