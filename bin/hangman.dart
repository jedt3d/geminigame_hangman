import 'dart:io';
import 'package:hangman/hangman.dart';

/// The entry point for the Hangman CLI game.
void main() {
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
  // We'll use a placeholder word for now. In future cycles, we'll implement a word generator.
  final game = HangmanGame(secretWord: 'GSD-DART');

  // 3. Display Initial State
  // This is the first "Render" phase of our game loop.
  print('====================================');
  print('   WELCOME TO GSD HANGMAN (CLI)     ');
  print('====================================');
  print('\nSecret Word: ${game.maskedWord}');
  print('Lives remaining: ${game.remainingLives}');
  print('\n(Wait for the next cycle to implement input handling!)');
}
