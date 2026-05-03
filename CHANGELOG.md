# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]

## [0.2.1] - 2026-05-03
### Added
- **Documentation**: Created a comprehensive `README.md` with project overview, features, and setup instructions.

## [0.2.0] - 2026-05-03
### Added
- **Gallows Graphic**: Implemented `HangmanGallows` class via TDD to provide ASCII art for the hangman.
- **Visual Feedback**: Integrated the gallows graphic into the main game loop to display the player's progress visually based on remaining lives.

## [0.1.0] - 2026-05-03
### Added
- **Dynamic Word Generation**: Implemented `WordGenerator` to load words from a dictionary file, replacing the hardcoded secret word. The game now selects a random word of 7+ letters at startup.
- **Game Loop**: Created the main interactive game loop (`Input -> Update -> Render`) in `bin/hangman.dart`.
- **Masked Word Display**: Added logic to show the secret word with unguessed letters masked by underscores (e.g., `H _ N G M _ N`).
- **Case-Insensitive Guessing**: User input is now normalized to uppercase, so 'a' and 'A' are treated as the same guess.
- **Core Game Logic**: Implemented the fundamental state management for tracking guesses and remaining lives via TDD.
- **CLI Entry Point & Validation**: Established `bin/hangman.dart` as the main entry point and added terminal size validation to ensure a stable UI.
- **Project Concepts & TDD Log**: Created `CONCEPT.md` to document architectural decisions and track TDD progress.
- **Initial Project Setup**: Basic project structure, dependencies, and `GEMINI.md` instructions.
