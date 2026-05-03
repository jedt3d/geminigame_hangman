/// Core logic and terminal utilities for the Hangman game.

/// Manages the state and rules of the Hangman game.
class HangmanGame {
  final String secretWord;
  int remainingLives;
  final Set<String> guessedLetters;

  /// Initializes a new game session.
  /// 
  /// [secretWord] is the target word to be guessed.
  /// [remainingLives] defaults to 6, a standard for Hangman.
  HangmanGame({
    required this.secretWord,
    this.remainingLives = 6,
  }) : guessedLetters = {};

  /// Processes a user's guess.
  /// 
  /// Returns `true` if the [letter] is in the [secretWord], `false` otherwise.
  /// Handles duplicate guesses by returning the same result without penalizing lives.
  bool guess(String letter) {
    // Normalize input to uppercase to keep it simple (we can refine this later)
    final normalized = letter.toUpperCase();

    // If already guessed, just return if it was correct or not
    if (guessedLetters.contains(normalized)) {
      return secretWord.contains(normalized);
    }

    guessedLetters.add(normalized);

    final isCorrect = secretWord.contains(normalized);
    if (!isCorrect) {
      remainingLives--;
    }

    return isCorrect;
  }

  /// Checks if the game is over (either won or lost).
  bool get isGameOver => remainingLives <= 0 || isWordGuessed;

  /// Checks if all letters in the [secretWord] have been guessed.
  bool get isWordGuessed {
    return secretWord.split('').every((letter) => guessedLetters.contains(letter));
  }
}

/// Utilities for validating the terminal environment.
class TerminalValidator {
  /// Minimum recommended width for the game UI.
  static const int minWidth = 80;
  
  /// Minimum recommended height for the game UI.
  static const int minHeight = 24;

  /// Validates if the terminal dimensions meet the minimum requirements.
  /// 
  /// This prevents "garbage" output caused by text wrapping on small screens.
  static bool isValid({required int width, required int height}) {
    return width >= minWidth && height >= minHeight;
  }
}
