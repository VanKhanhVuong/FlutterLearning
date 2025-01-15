import 'package:flutter/material.dart';
import 'package:flutter_rpg/create/vocation_card.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

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

  // handling vocation selection
  Vocation selectionVocation = Vocation.junkie;

  void updateVocation(Vocation vocation) {
    setState(() {
      selectionVocation = vocation;
    });
  }

  // Submit Handler
  void handleSubmit() {
    if (_nameController.text.trim().isEmpty) {
      // TODO: Show error dialog
      return;
    }

    if (_sloganController.text.trim().isEmpty) {
      // TODO: Show error dialog
      return;
    }

    characters.add(Character(
      id: uuid.v4(),
      vocation: selectionVocation,
      name: _nameController.text.trim(),
      slogan: _sloganController.text.trim(),
    ));
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

        // Thêm Scroll view vào cho không bị tràn layout
        child: SingleChildScrollView(
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
                  prefixIcon: Icon(Icons.person_2),
                  labelText: 'Character Name'),
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

            // Selected vocation title
            Center(
              child: Icon(
                Icons.code,
                color: AppColors.primaryColor,
              ),
            ),
            const Center(
              child: StyledHeading('Choose a vocation.'),
            ),
            const Center(
              child: StyledText('This determines your availabel skills.'),
            ),

            // vocation cards
            VocationCard(
              onTap: updateVocation,
              vocation: Vocation.junkie,
              selected: selectionVocation == Vocation.junkie,
            ),
            VocationCard(
              onTap: updateVocation,
              vocation: Vocation.ninja,
              selected: selectionVocation == Vocation.ninja,
            ),
            VocationCard(
              onTap: updateVocation,
              vocation: Vocation.raider,
              selected: selectionVocation == Vocation.raider,
            ),
            VocationCard(
              onTap: updateVocation,
              vocation: Vocation.wizard,
              selected: selectionVocation == Vocation.wizard,
            ),

            // Button to submit the form
            Center(
              child: StyledButton(
                onPressed: handleSubmit,
                child: const StyledHeading('Create Character'),
              ),
            ),

            // Good luck message
            Center(
              child: Icon(
                Icons.code,
                color: AppColors.primaryColor,
              ),
            ),
            const Center(
              child: StyledHeading('Good Luck.'),
            ),
            const Center(
              child: StyledText('And enjoy the journey.....'),
            ),
          ]),
        ),
      ),
    );
  }
}
