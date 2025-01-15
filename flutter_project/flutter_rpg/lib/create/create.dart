import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  // Text Field Controller
  final _nameController = TextEditingController();
  final _sloganController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _sloganController.dispose();

    super.dispose();
  }

  // Submit Handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      print('name must not be empty');
      return;
    }

    if (_sloganController.text.trim().isEmpty) {
      print('slogan must not be empty');
      return;
    }
    print(_nameController.text.trim());
    print(_sloganController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const StyledTitle("Character Creation"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(children: [
          // Wellcome message
          Center(
            child: Icon(
              Icons.code,
              color: AppColors.primaryColor,
            ),
          ),
          const Center(
            child: StyledHeading('Welcome, new player.'),
          ),
          const Center(
            child: StyledText('Create a name & slogan for your character.'),
          ),
          const SizedBox(
            height: 30,
          ),

          // Input for name and slogan

          TextField(
            controller: _nameController,
            style: GoogleFonts.kanit(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),

            // Đổi màu con trỏ thành màu xám (Mặc định là màu đỏ)
            cursorColor: AppColors.textColor,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_2), labelText: 'Character Name'),
          ),

          const SizedBox(
            height: 20,
          ),

          TextField(
            controller: _sloganController,
            style: GoogleFonts.kanit(
              textStyle: Theme.of(context).textTheme.bodyMedium,
            ),
            cursorColor: AppColors.textColor,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.chat), labelText: 'Character Slogan'),
          ),

          const SizedBox(
            height: 30,
          ),

          // Button to submit the form
          Center(
            child: StyledButton(
              onPressed: handleSubmit,
              child: const StyledHeading('Create Character'),
            ),
          )
        ]),
      ),
    );
  }
}
