import 'package:hangman/hangman.dart';
import 'package:test/test.dart';

void main() {
  group('HangmanGame Logic', () {
    test('Initial state is correct', () {
      final game = HangmanGame(secretWord: 'DART');
      
      expect(game.secretWord, equals('DART'));
      expect(game.remainingLives, equals(6));
      expect(game.guessedLetters, isEmpty);
      expect(game.isGameOver, isFalse);
    });

    test('Correct guess updates state', () {
      final game = HangmanGame(secretWord: 'DART');
      
      final result = game.guess('A');
      
      expect(result, isTrue, reason: 'A correct guess should return true');
      expect(game.guessedLetters, contains('A'));
      expect(game.remainingLives, equals(6), reason: 'Correct guess should not reduce lives');
    });

    test('Incorrect guess updates state', () {
      final game = HangmanGame(secretWord: 'DART');
      
      final result = game.guess('Z');
      
      expect(result, isFalse, reason: 'An incorrect guess should return false');
      expect(game.guessedLetters, contains('Z'));
      expect(game.remainingLives, equals(5));
    });

    test('Duplicate guess does not penalize', () {
      final game = HangmanGame(secretWord: 'DART');
      
      game.guess('Z');
      expect(game.remainingLives, equals(5));
      
      final result = game.guess('Z');
      expect(result, isFalse);
      expect(game.remainingLives, equals(5), reason: 'Duplicate incorrect guess should not reduce lives twice');
    });

    test('Guessing is case-insensitive', () {
      // WHY: Users shouldn't be punished for having Caps Lock on or off.
      // We normalize everything to uppercase internally.
      final game = HangmanGame(secretWord: 'Dart'); // Mixed case secret word
      
      expect(game.guess('d'), isTrue, reason: 'Lowercase guess should match uppercase letter');
      expect(game.guess('A'), isTrue, reason: 'Uppercase guess should match lowercase letter');
      expect(game.guessedLetters, contains('D'));
      expect(game.guessedLetters, contains('A'));
    });

    test('Masked word representation is correct', () {
      // WHY: The player needs to see the progress of their guesses.
      // Correct guesses reveal letters, others remain as underscores.
      final game = HangmanGame(secretWord: 'HANGMAN');
      
      expect(game.maskedWord, equals('_ _ _ _ _ _ _'), reason: 'Initial word should be all underscores');
      
      game.guess('A');
      expect(game.maskedWord, equals('_ A _ _ _ A _'), reason: 'Guessed letter "A" should be revealed');
      
      game.guess('N');
      expect(game.maskedWord, equals('_ A N _ _ A N'), reason: 'Guessed letter "N" should be revealed');
      
      game.guess('H');
      expect(game.maskedWord, equals('H A N _ _ A N'), reason: 'Guessed letter "H" should be revealed');
    });
  });

  group('Terminal Size Guarding', () {
    test('isTerminalSizeValid returns true when size is sufficient', () {
      // Expecting 80x24 to be the minimum
      expect(TerminalValidator.isValid(width: 80, height: 24), isTrue);
      expect(TerminalValidator.isValid(width: 100, height: 50), isTrue);
    });

    test('isTerminalSizeValid returns false when size is too small', () {
      expect(TerminalValidator.isValid(width: 79, height: 24), isFalse);
      expect(TerminalValidator.isValid(width: 80, height: 23), isFalse);
    });
  });
}
