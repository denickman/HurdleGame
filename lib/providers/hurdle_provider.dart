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
  int index = 0;
  bool wins = false;

  final totalAttempts = 6;
  int attempts = 0;

  bool get shouldCheckForAnswer => rowInputs.length == lettersPerRow;
  bool get noAttemptsLeft => attempts == totalAttempts;

  //   bool get shouldCheckForAnswer {
  //      final result = rowInputs.length == lettersPerRow;
  // debugPrint('shouldCheckForAnswer: $result | rowInputs: $rowInputs');
  // return result;
  //   }

  init() {
    totalWords = words.all.where((element) => element.length == 5).toList();
    generateBoard();
    generateRandomWord();
  }

  void deleteLetter() {
    if (rowInputs.isNotEmpty) {
      rowInputs.removeAt(rowInputs.length - 1);
      print(rowInputs);
    }

    if (count > 0) {
      hurdleBoard[index - 1] = Wordle(letter: '');
      count--;
      index--;
    }

    notifyListeners();
  }

  generateBoard() {
    hurdleBoard = List.generate(30, (index) => Wordle(letter: ''));
  }

  generateRandomWord() {
    targetWord = totalWords[randomIndex.nextInt(totalWords.length)]
        .toUpperCase();
    debugPrint(targetWord);
  }

  bool get isAValidWord =>
      totalWords.contains(rowInputs.join('').toLowerCase());

  inputLetter(String letter) {
    if (count < lettersPerRow) {
      rowInputs.add(letter);
      hurdleBoard[index] = Wordle(letter: letter);
      count++;
      index++;
    }

    debugPrint('Row inputs');
    notifyListeners();
  }

  void checkAnswer() {
    final input = rowInputs.join('').toUpperCase();

    print('input $input');
    print('Target Word $targetWord');

    if (targetWord == input) {
      print('TRUE');
      wins = true;
    } else {
      _markLetterOnBoard();
      if (attempts < totalAttempts) {
        _goToNextRow();
      }
    }
  }

  void _goToNextRow() {
    attempts++;
    count = 0;
    rowInputs.clear();
  }

  void _markLetterOnBoard() {
    for (int i = 0; i < hurdleBoard.length; i++) {
      if (hurdleBoard[i].letter.isNotEmpty &&
          targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].existInTarget = true;
      } else if (hurdleBoard[i].letter.isNotEmpty &&
          !targetWord.contains(hurdleBoard[i].letter)) {
        hurdleBoard[i].doesNotExistInTarget = true;
        excludedLetters.add(hurdleBoard[i].letter);
      }
    }

    notifyListeners();
  }


  reset() {
    count = 0;
    index = 0;
    rowInputs.clear();
    hurdleBoard.clear();
    excludedLetters.clear();
    attempts = 0;
    wins = false;
    targetWord = '';
    generateBoard();
    generateRandomWord();
    notifyListeners();
  }
}
