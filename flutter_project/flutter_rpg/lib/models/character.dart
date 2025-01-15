import 'package:flutter_rpg/models/skill.dart';
import 'package:flutter_rpg/models/stats.dart';
import 'package:flutter_rpg/models/vocation.dart';

class Character with Stats {
// Constructor
  Character({
    required this.name,
    required this.slogan,
    required this.id,
    required this.vocation,
  });

  // Fields
  final Set<Skill> skills = {};
  final Vocation vocation;
  final String name;
  final String slogan;
  final String id;
  bool _isFav = false;

  // Getters
  bool get isFav => _isFav;

  // Methods

  // Phương thức chọn yêu thích nhân vật
  void toggleIsFav() {
    _isFav = !_isFav;
  }

  // Phương thức cập nhật skill nhân vật
  void updateSkill(Skill skill) {
    skills.clear();
    skills.add(skill);
  }
}
