import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/theme.dart';

class Heart extends StatefulWidget {
  const Heart({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  State<Heart> createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  late AnimationController _controler;

  late Animation _sizeAnimation;

  @override
  void initState() {
    _controler =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);

    _sizeAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween(begin: 25, end: 40),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 40, end: 25),
        weight: 50,
      ),
    ]).animate(_controler);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controler,
        builder: (context, child) {
          return IconButton(
            icon: Icon(
              Icons.favorite,
              color: widget.character.isFav
                  ? AppColors.primaryAccent
                  : Colors.grey[800],
              size: _sizeAnimation.value,
            ),
            onPressed: () {
              _controler.reset();
              _controler.forward();
              widget.character.toggleIsFav();
            },
          );
        });
  }
}
