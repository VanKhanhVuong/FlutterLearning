import 'package:flutter_rpg/models/stats.dart';

class Character with Stats {
// Constructor
  Character({required this.name, required this.slogan});

  // Fields
  final String name;
  final String slogan;
  bool _isFav = false;

  void toggleIsFav() {
    _isFav = !_isFav;
  }
}
