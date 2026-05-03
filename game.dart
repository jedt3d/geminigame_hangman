class Game {
  final String secretWord;
  final List<String> _guessedLetters = [];
  int maxGuesses;
  int _remainingGuesses;

  Game({required this.secretWord, this.maxGuesses = 6})
      : _remainingGuesses = maxGuesses {
    if (secretWord.isEmpty) {
      throw ArgumentError('Secret word cannot be empty.');
    }
  }

  int get remainingGuesses => _remainingGuesses;
  List<String> get guessedLetters => List.unmodifiable(_guessedLetters);

  String get displayedWord {
    return secretWord.split('').map((letter) {
      return _guessedLetters.contains(letter.toLowerCase()) ? letter : '_';
    }).join(' ');
  }

  bool guess(String letter) {
    if (letter.length != 1 || !_isAlpha(letter)) {
      return false;
    }

    final lowerCaseLetter = letter.toLowerCase();

    if (_guessedLetters.contains(lowerCaseLetter)) {
      return false;
    }

    _guessedLetters.add(lowerCaseLetter);

    if (secretWord.toLowerCase().contains(lowerCaseLetter)) {
      return true; // Correct guess
    } else {
      _remainingGuesses--;
      return false; // Incorrect guess
    }
  }

  bool _isAlpha(String str) {
    return str.runes.every((rune) {
      final char = String.fromCharCode(rune);
      return (char.compareTo('a') >= 0 && char.compareTo('z') <= 0) ||
          (char.compareTo('A') >= 0 && char.compareTo('Z') <= 0);
    });
  }

  bool isWon() => secretWord
      .split('')
      .every((letter) => _guessedLetters.contains(letter.toLowerCase()));

  bool isLost() => _remainingGuesses <= 0;
}