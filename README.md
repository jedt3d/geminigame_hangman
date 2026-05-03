<div align="center">

# GSD Hangman (Dart CLI)

A classic command-line Hangman game built with Dart, focusing on clean architecture and Test-Driven Development (TDD).

</div>

---

## 🎮 Gameplay Demo

A snapshot of the game in action. The gallows display updates with each incorrect guess, and the secret word is revealed as you guess correctly.

```
====================================
      GSD HANGMAN (DART CLI)
====================================
   +---+
   |   |
   O   |
  /|\  |
       |
       |
=========

Lives remaining: 2
Guessed letters: A, E, I, O, S, T, X, Y, Z

Secret Word: _ _ _ A _ E _ _

Guess a letter: 
```

## ✨ Features

- **Interactive Gameplay**: A full game loop with input, state updates, and screen rendering.
- **Dynamic Word Generation**: Pulls words from an external dictionary file for high replayability.
- **Visual Gallows**: Classic ASCII art gallows that update with each wrong guess.
- **Clean Architecture**: Logic is strictly separated from the UI, enabling comprehensive testing.
- **TDD-Driven**: Developed following a rigorous Test-Driven Development methodology.

## 🚀 Getting Started

### Requirements
- Dart SDK (version 3.0 or later)

### Installation & Running
1.  **Install dependencies:**
    ```bash
    dart pub get
    ```
2.  **Run the game:**
    ```bash
    dart run bin/hangman.dart
    ```

### Running Tests

To run the full suite of unit tests, execute:
```bash
dart test
```

## 🏛️ Project Philosophy

This project was built with a "Get Shit Done" (GSD) mindset, emphasizing rapid, iterative progress through a strict TDD workflow. For a deeper dive into the architectural decisions and TDD cycles, please see the **CONCEPT.md** file.
