import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/screens/post/checkout_qrcode_screen.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends HookWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useRef(GlobalKey<FormState>());
    final priceController = useTextEditingController();
    final numberFormat = NumberFormat("#,###", "en_US");

    int getPrice() {
      try {
        String cleanValue = priceController.text.replaceAll(',', '');
        return int.parse(cleanValue);
      } catch (e) {
        return 0;
      }
    }

    /// Format số tiền khi nhập vào
    void formatPriceInput(String value) {
      String cleanValue = value.replaceAll(',', '');
      if (cleanValue.isEmpty) return;

      final newValue = numberFormat.format(int.parse(cleanValue));
      priceController.value = TextEditingValue(
        text: newValue,
        selection: TextSelection.collapsed(offset: newValue.length),
      );
    }

    Future<void> handleGenQRCode() async {
      if (!formKey.value.currentState!.validate()) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => CheckoutQrcodeScreen(amount: getPrice().toString()),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Payment Screen'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: StyledBodyText('Generate QR Code Screen')),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                onChanged: formatPriceInput,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: handleGenQRCode,
                child: const Text('Generate QR Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
