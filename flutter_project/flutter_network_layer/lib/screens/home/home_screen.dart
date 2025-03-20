import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_network_layer/screens/settings/settings_screen.dart';
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
          _buildMenuItem(
            context,
            'Payment',
            Icons.qr_code_2,
            const PaymentScreen(),
          ),
          _buildMenuItem(
            context,
            'Post List',
            Icons.list,
            const PostListScreen(),
          ),
          _buildMenuItem(
            context,
            'Settings',
            Icons.settings,
            const SettingsScreen(),
          ),
          // _buildMenuItem(context, 'Option 4', Icons.info, const Option4Screen()),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
