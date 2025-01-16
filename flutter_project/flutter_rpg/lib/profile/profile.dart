import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_text.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle('Character name'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Basic info - image, vocation, description

            // Weapon and ability

            // Stats & skills

            // Save Button
          ],
        ),
      ),
    );
  }
}
