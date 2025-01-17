import 'package:cloud_firestore/cloud_firestore.dart';
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
  void updateSkills(Skill skill) {
    skills.clear();
    skills.add(skill);
  }

  // Character to Firestore (Map)
  // Hàm chuyển model Character thành JSON để lưu vào Firestore
  // Map theo cặp KEY kiểu String và VALUE kiểu dynamic
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'slogan': slogan,
      'vocation': vocation.toString(),
      'skills': skills.isNotEmpty ? skills.map((s) => s.id).toList() : [],
      'isFav': _isFav,
      'stats': statsAsMap,
      'points': points,
    };
  }

  // Firestore to Character
  // Hàm chuyển JSON Firestore thành model Character
  // Lấy dữ liệu từ DocumentSnapshot của Firestore
  //
  factory Character.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    // Get data from Snapshot
    final data = snapshot.data()!;

    // Make character instance
    Character character = Character(
      id: snapshot.id,
      name: data['name'],
      slogan: data['slogan'],
      vocation: Vocation.values
          .firstWhere((vocation) => vocation.toString() == data['vocation']),
    );

    // Get all skills for character
    // Lấy toàn bộ skill mà nhân vật có để lưu vào model

    if (data.containsKey('skills') &&
        data['skills'] is List &&
        data['skills'].isNotEmpty) {
      for (String id in data['skills']) {
        Skill skill = allSkills.firstWhere((element) => element.id == id);
        character.updateSkills(skill);
      }
    } else {
      print('No skills available or skills key is missing.');
    }

    // Get isFav
    // Lấy dữ liệu boolean trên Firetore chuyển về lưu vào model
    if (data['isFav'] == true) {
      character.toggleIsFav();
    }

    // Get stats & points character
    // Lấy dữ liệu về points và stats lưu dưới dạng Map của Firestore
    // chuyển về lưu vào model bằng hàm setStat() dùng để cập nhật.
    character.setStat(points: data['points'], stats: data['stats']);

    return character;
  }
}
