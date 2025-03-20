import 'package:flutter/material.dart';

class CheckoutQrcodeScreen extends StatelessWidget {
  final String amount;

  const CheckoutQrcodeScreen({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final String qrImageUrl =
        "https://img.vietqr.io/image/vietinbank-105875306691-qr_only.png"
        "?amount=$amount"
        "&addInfo=Khach Hang thanh toan"
        "&accountName=Kh%C3%A1nh%20V%C6%B0%C6%A1ng";

    return Scaffold(
      appBar: AppBar(title: const Text("VietQR Code")),
      body: Center(child: Image.network(qrImageUrl)),
    );
  }
}
