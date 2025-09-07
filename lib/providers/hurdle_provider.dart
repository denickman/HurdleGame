import 'dart:math';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart' as words;
import 'package:hurdleapp/models/wordle.dart';

class HurdleProvider extends ChangeNotifier {
  final randomIndex = Random.secure();
  List<String> totalWords = [];
  List<String> rowInputs = [];
  List<String> excludedLetters = [];
  List<Wordle> hurdleBoard = [];

  String targetWord = '';
  int count = 0;
  final lettersPerRow = 5;

  init() {
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandomWord();
  }

  generateBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  generateRandomWord() {
    targetWord = totalWords[randomIndex.nextInt(totalWords.length)]
        .toUpperCase();
    debugPrint(targetWord);
  }

  inputLetter(String letter) {
    if (count < lettersPerRow) {
      count++;
      rowInputs.add(letter);
    }

    debugPrint('Row inputs');
    debugPrint(rowInputs);
  }
}
