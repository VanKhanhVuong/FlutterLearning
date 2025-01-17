import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/services/firestore_service.dart';

/*
  Ở đây dùng Provider tương tự như (Combine / RxSwift) trong iOS

  notifyListeners() : là như một cách thông báo 1 character 
  đã được add và những widget có liên quan rebuild lại
*/

class CharacterStore extends ChangeNotifier {
  final List<Character> _characters = [];

  get characters => _characters;

  // Add character
  void addCharacter(Character character) {
    // Save the character to the database
    FirestoreService.addCharacter(character);

    // Refresh state
    _characters.add(character);
    notifyListeners();
  }

  // Save (update) character

  // Remove character

  // Initially fetch characters
  void fetchCharacterOnce() async {
    // Check if character list is empty
    if (characters.isEmpty()) {
      // Fetch characters from Firestore database and add them to the list
      final snapshot = await FirestoreService.getCharacterOnce();

      for (var doc in snapshot.docs) {
        _characters.add(doc.data());
      }

      // Notify all listeners that the state has been updated
      notifyListeners();
    }
  }
}
