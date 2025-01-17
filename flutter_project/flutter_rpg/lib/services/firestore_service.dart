import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rpg/models/character.dart';

class FirestoreService {
  static final ref =
      FirebaseFirestore.instance.collection('characters').withConverter(
            fromFirestore: Character.fromFirestore,
            toFirestore: (Character character, _) => character.toFirestore(),
          );

  // Add a new character
  static Future<void> addCharacter(Character character) async {
    await ref.doc(character.id).set(character);
  }

  // Get characters once
  static Future<QuerySnapshot<Character>> getCharacterOnce() async {
    return ref.get();
  }

  // Update a character

  // Delete a character
}
