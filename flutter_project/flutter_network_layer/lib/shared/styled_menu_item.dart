import 'package:flutter/material.dart';

class StyledMenuItem extends StatelessWidget {
  const StyledMenuItem({
    super.key,
    required this.title,
    required this.icon,
    required this.screen,
  });

  final String title;
  final IconData icon;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
