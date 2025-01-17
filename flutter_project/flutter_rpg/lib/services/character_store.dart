import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/models/vocation.dart';

/*
  Ở đây dùng Provider tương tự như (Combine / RxSwift) trong iOS

  notifyListeners() : là như một cách thông báo 1 character 
  đã được add và những widget có liên quan rebuild lại
*/

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [
    Character(
      name: 'Klara',
      slogan: 'The mighty warrior',
      id: '1',
      vocation: Vocation.wizard,
    ),
    Character(
      name: 'Jonny',
      slogan: 'The cunning rogue',
      id: '2',
      vocation: Vocation.junkie,
    ),
    Character(
      name: 'Crimson',
      slogan: 'Fire in the hole!',
      id: '3',
      vocation: Vocation.raider,
    ),
    Character(
      name: 'Richard',
      slogan: 'Flyyy!',
      id: '4',
      vocation: Vocation.ninja,
    ),
  ];

  get characters => _characters;

  // Add character
  void addCharacter(Character character) {
    _characters.add(character);
    notifyListeners();
  }

  // Save (update) character

  // Remove character

  // Initially fetch characters
}
