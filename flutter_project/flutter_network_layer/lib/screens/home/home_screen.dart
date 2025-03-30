import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/screens/english/get_list_flash_card_screen.dart';
import 'package:flutter_network_layer/screens/settings/settings_screen.dart';
import 'package:flutter_network_layer/screens/upload/file_picker_screen.dart';
import 'package:flutter_network_layer/shared/styled_menu_item.dart';
import 'package:flutter_network_layer/shared/styled_text.dart';

// Import các màn hình đích
import 'package:flutter_network_layer/screens/payment/payment_screen.dart';
import 'package:flutter_network_layer/screens/post/post_list_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Home Screen'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: ListView(
        children: [
          StyledMenuItem(
            title: 'Payment',
            icon: Icons.qr_code_2,
            screen: PaymentScreen(),
          ),
          StyledMenuItem(
            title: 'Post List',
            icon: Icons.list,
            screen: PostListScreen(),
          ),
          StyledMenuItem(
            title: 'Settings',
            icon: Icons.settings,
            screen: SettingsScreen(),
          ),
          StyledMenuItem(
            title: 'Files',
            icon: Icons.open_in_browser,
            screen: FilePickerScreen(),
          ),
          StyledMenuItem(
            title: 'FlashCard List',
            icon: Icons.list,
            screen: FlashCardScreen(),
          ),
        ],
      ),
    );
  }
}
