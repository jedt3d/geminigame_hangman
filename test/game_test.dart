import 'package:hangman/src/game.dart';
import 'package:test/test.dart';

void main() {
  group('Game', () {
    late Game game;

    setUp(() {
      game = Game(secretWord: 'Dart');
    });

    test('constructor throws error for empty secret word', () {
      expect(() => Game(secretWord: ''), throwsArgumentError);
    });

    test('initial state is correct', () {
      expect(game.secretWord, 'Dart');
      expect(game.remainingGuesses, 6);
      expect(game.guessedLetters, isEmpty);
      expect(game.displayedWord, '_ _ _ _');
    });

    test('correct guess reveals letter', () {
      final correct = game.guess('a');
      expect(correct, isTrue);
      expect(game.displayedWord, '_ a _ _');
      expect(game.guessedLetters, ['a']);
      expect(game.remainingGuesses, 6);
    });

    test('incorrect guess decrements remaining guesses', () {
      final correct = game.guess('z');
      expect(correct, isFalse);
      expect(game.displayedWord, '_ _ _ _');
      expect(game.guessedLetters, ['z']);
      expect(game.remainingGuesses, 5);
    });

    test('guess is case-insensitive', () {
      game.guess('D');
      expect(game.displayedWord, 'D _ _ _');
      game.guess('t');
      expect(game.displayedWord, 'D _ _ t');
    });

    test('guessing an already guessed letter returns false', () {
      game.guess('a');
      final correct = game.guess('a');
      expect(correct, isFalse);
      expect(game.remainingGuesses, 6); // Should not decrement
    });

    test('invalid guess (multiple letters) returns false', () {
      final correct = game.guess('ab');
      expect(correct, isFalse);
      expect(game.remainingGuesses, 6);
      expect(game.guessedLetters, isEmpty);
    });

    test('invalid guess (non-alphabetic) returns false', () {
      final correct = game.guess('1');
      expect(correct, isFalse);
      expect(game.remainingGuesses, 6);
      expect(game.guessedLetters, isEmpty);
    });

    test('isWon returns true when all letters are guessed', () {
      game.guess('d');
      game.guess('a');
      game.guess('r');
      game.guess('t');
      expect(game.isWon(), isTrue);
      expect(game.isLost(), isFalse);
    });

    test('isLost returns true when all guesses are used', () {
      game.guess('z');
      game.guess('y');
      game.guess('x');
      game.guess('w');
      game.guess('v');
      game.guess('u');
      expect(game.isLost(), isTrue);
      expect(game.isWon(), isFalse);
    });
  });
}