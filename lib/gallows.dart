/// Provides the ASCII art for the hangman gallows at different stages.
class HangmanGallows {
  // A list of multi-line strings, where each string is a stage of the gallows.
  // Index 0 is the initial state (6 lives remaining).
  // Index 6 is the final state (0 lives remaining).
  static const List<String> _stages = [
    // Stage 0 (6 lives)
    '''
   +---+
   |   |
       |
       |
       |
       |
=========''',
    // Stage 1 (5 lives)
    '''
   +---+
   |   |
   O   |
       |
       |
       |
=========''',
    // Stage 2 (4 lives)
    '''
   +---+
   |   |
   O   |
   |   |
       |
       |
=========''',
    // Stage 3 (3 lives)
    '''
   +---+
   |   |
   O   |
  /|   |
       |
       |
=========''',
    // Stage 4 (2 lives)
    '''
   +---+
   |   |
   O   |
  /|\\  |
       |
       |
=========''',
    // Stage 5 (1 life)
    '''
   +---+
   |   |
   O   |
  /|\\  |
  /    |
       |
=========''',
    // Stage 6 (0 lives)
    '''
   +---+
   |   |
   O   |
  /|\\  |
  / \\  |
       |
=========''',
  ];

  /// Returns the gallows graphic for a given number of remaining lives.
  ///
  /// [remainingLives] must be between 0 and 6.
  static String getGraphicForLives(int remainingLives) {
    if (remainingLives < 0 || remainingLives > 6) {
      throw RangeError('remainingLives must be between 0 and 6, but was $remainingLives.');
    }
    // Map lives to stage index. 6 lives -> index 0, 0 lives -> index 6.
    final stageIndex = 6 - remainingLives;
    return _stages[stageIndex];
  }
}