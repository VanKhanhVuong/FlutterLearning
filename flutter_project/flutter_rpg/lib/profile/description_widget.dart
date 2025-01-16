import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_text.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyledHeading(title),
        StyledText(content),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
