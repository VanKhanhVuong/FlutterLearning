import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/profile/profile.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Hero(
              tag: character.id.toString(),
              child: Image.asset(
                'assets/img/vocations/${character.vocation.image}',
                width: 80,
              ),
            ),

            const SizedBox(width: 20),

            Column(
              // Cho đoạn text nằm ngang hàng nhau về phía bên trái
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StyledHeading(character.name),
                StyledText(character.vocation.title),
              ],
            ),

            // Text(character.name),
            const Expanded(
              child: SizedBox(),
            ),

            // Arrow icon show details character
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => Profile(
                              character: character,
                            )));
              },
              icon: Icon(
                Icons.arrow_forward,
                color: AppColors.textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
