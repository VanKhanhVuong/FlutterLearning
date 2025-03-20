import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/domain/entities/post.dart';
import 'package:flutter_network_layer/screens/post/checkout_qrcode_screen.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostDetailScreen extends HookWidget {
  final Post post;
  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final amount = useState<int>(1);

    void increaseAmount() {
      amount.value += 1;
    }

    void decreaseAmount() {
      if (amount.value > 1) {
        amount.value -= 1;
      }
    }

    int getPrice() {
      try {
        return int.parse(post.description) * amount.value;
      } catch (e) {
        return 0;
      }
    }

    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(post.name),
            backgroundColor: Colors.blue[500],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CachedNetworkImage(
                    imageUrl: post.image,
                    placeholder:
                        (context, url) => const CircularProgressIndicator(),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 16.0),
                StyledHeading(post.name),
                const SizedBox(height: 8.0),
                StyledBodyText(post.description),

                // --- Tăng/Giảm Amount ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, color: Colors.red),
                      onPressed: decreaseAmount,
                    ),
                    StyledBodyText("${amount.value}"),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.green),
                      onPressed: increaseAmount,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                // --- Thanh toán ---
                StyledBodyText("Thanh toán số tiền : ${getPrice()} VND"),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          CheckoutQrcodeScreen(amount: getPrice().toString()),
                ),
              );
            },
            backgroundColor: Colors.blue,
            child: Icon(Icons.qr_code),
          ),
        );
      },
    );
  }
}
