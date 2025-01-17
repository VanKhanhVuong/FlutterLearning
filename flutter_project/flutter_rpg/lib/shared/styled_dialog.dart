import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';

class StyledDialog extends StatelessWidget {
  const StyledDialog({
    super.key,
    required this.title,
    required this.content,
    required this.titleButton,
    required this.onPressed,
  });

  final String title;
  final String content;
  final String titleButton;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: StyledHeading(title),
      content: StyledText(content),
      actions: [
        StyledButton(
          onPressed: onPressed,
          child: StyledHeading(titleButton),
        )
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
