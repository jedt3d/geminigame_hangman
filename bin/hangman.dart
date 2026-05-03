import 'dart:io';
import 'package:hangman/hangman.dart';
import 'package:hangman/gallows.dart';
import 'package:hangman/word_generator.dart';

/// The entry point for the Hangman CLI game.
void main() async {
  // Clear the terminal screen using ANSI escape codes
  // \x1B[2J clears the screen, \x1B[H moves the cursor to (0,0)
  stdout.write('\x1B[2J\x1B[H');

  // Fetch current terminal dimensions
  final width = stdout.terminalColumns;
  final height = stdout.terminalLines;

  // 1. Check Dimensions
  // We use the TerminalValidator we built via TDD to ensure the UI won't break.
  if (!TerminalValidator.isValid(width: width, height: height)) {
    print('⚠️  TERMINAL TOO SMALL');
    print('Please resize your terminal to at least ${TerminalValidator.minWidth}x${TerminalValidator.minHeight}.');
    print('Current size: ${width}x${height}');
    
    // Exit with code 1 to indicate a requirement failure
    exit(1);
  }

  // 2. Initialize Game
  // Load a random word from our dictionary.
  final String secretWord;
  try {
    // We create a WordGenerator and initialize it.
    final wordGenerator = WordGenerator(filePath: 'bin/words.txt');
    await wordGenerator.initialize();
    secretWord = wordGenerator.getRandomWord();
  } catch (e) {
    print('❌ Error initializing game:');
    print(e);
    exit(1);
  }

  // Create the game instance with the randomly selected word.
  final game = HangmanGame(secretWord: secretWord);

  // 3. Game Loop (Input -> Update -> Render)
  while (!game.isGameOver) {
    // RENDER PHASE: Clear the screen and draw the current game state.
    stdout.write('\x1B[2J\x1B[H');
    print('====================================');
    print('      GSD HANGMAN (DART CLI)        ');
    print('====================================');

    // Draw the gallows based on remaining lives.
    print(HangmanGallows.getGraphicForLives(game.remainingLives));

    print('Lives remaining: ${game.remainingLives}');
    // Display guessed letters sorted for consistency.
    print('Guessed letters: ${(game.guessedLetters.toList()..sort()).join(', ')}\n');
    print('Secret Word: ${game.maskedWord}\n');

    // INPUT PHASE: Prompt the user and read their guess.
    stdout.write('Guess a letter: ');
    final input = stdin.readLineSync();

    // UPDATE PHASE: Process the input and update the game state.
    if (input != null && input.trim().isNotEmpty) {
      // We only care about the first character of the input.
      game.guess(input.trim()[0]);
    }
  }

  // 4. Game Over Screen
  stdout.write('\x1B[2J\x1B[H'); // Final clear for the result screen.
  print('====================================');
  print('            GAME OVER               ');
  print('====================================\n');

  if (game.isWordGuessed) {
    print('🎉 YOU WON! 🎉\n');
  } else {
    print('💀 YOU LOST! 💀\n');
  }

  print('The word was: ${game.secretWord}');
}
