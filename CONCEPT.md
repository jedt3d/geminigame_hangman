# Project Concepts & Architecture

This file serves as a repository for key technical concepts and architectural decisions made during the development of the Hangman CLI project.

## CLI Game Engine Principles

### 1. The Game Loop
The fundamental rhythm of the game: **Input → Update → Render**.
- **Input:** Capture user keyboard input.
- **Update:** Apply game logic (check letters, update lives, verify win/loss).
- **Render:** Output the updated state to the terminal.

### 2. State Management
A central "Source of Truth" for the game's data at any given moment.
- **Secret Word:** The word to be guessed.
- **Guessed Letters:** Tracking attempted letters (using a Set for uniqueness).
- **Remaining Lives:** Counter for incorrect guesses.
- **Game Status:** Current state (e.g., `playing`, `won`, `lost`).

### 3. I/O Separation
A critical design pattern for testability.
- **Pure Logic:** Game rules and state changes should be independent of `stdin`/`stdout`.
- **I/O Layer:** A thin wrapper that handles terminal interaction.
- **Benefit:** Allows for 100% test coverage of game logic without needing an active terminal session.

### 4. TDD-First Approach
Focus on building and verifying the "Brain" (Logic/State) before the "Body" (Loop/IO).
- Tests define how the state should change before any implementation code is written.

## Terminal Resilience & Resizing

### 1. The Clear-and-Redraw Pattern
To prevent "garbage" output and text reflow artifacts when a terminal is resized:
- **Detect Resize:** Listen for `ProcessSignal.sigwinch` (on POSIX) or poll dimensions (on Windows).
- **Clear Screen:** Wipe the entire terminal buffer.
- **Reset Cursor:** Move the cursor to `(0,0)`.
- **Full Redraw:** Render the entire game state from scratch based on new dimensions.

### 2. Dimension Guarding (Responsive UI)
A CLI game requires a "Safe Zone" to display the UI (e.g., the Hangman gallows, the word, and guessed letters).
- **Minimum Requirements:** Define `MIN_WIDTH` and `MIN_HEIGHT` (e.g., 80x24).
- **Threshold Check:** During the Render phase, if `terminalColumns < MIN_WIDTH` or `terminalLines < MIN_HEIGHT`:
    - Display a "Terminal Too Small" warning.
    - Pause game updates until the terminal is enlarged.
- **Dynamic Centering:** Calculate horizontal and vertical padding dynamically using `stdout.terminalColumns` and `stdout.terminalLines` to keep the UI centered.

## User-Friendly Input & Normalization

### 1. Case Insensitivity
In a CLI game, requiring the user to match the case of the secret word (e.g., 'a' vs 'A') creates unnecessary friction.
- **Implementation:** Both the `secretWord` and the user's `guess` should be normalized (e.g., `.toUpperCase()`) before comparison.
- **Why TDD?** We write tests for this to ensure that even if the game is initialized with a lowercase word, an uppercase guess still matches.

## Terminal Screen Refreshing (Fundamentals)

### 1. The Screen Buffer
The terminal is essentially a grid of characters. When you `print()`, you are appending to the bottom of the buffer. 
- **The Problem:** Without refreshing, the terminal becomes a "infinite scroll" of every state of the game, making it hard to follow.

### 2. The "Clear-and-Redraw" vs. "Surgical Update"
- **Surgical Update:** Moving the cursor to a specific `(x, y)` and overwriting just one character. Very fast, but complex to manage.
- **Clear-and-Redraw (Recommended):**
    1. Send the ANSI escape code `\x1B[2J` (Clear Screen) and `\x1B[H` (Home Cursor).
    2. Redraw the entire UI.
    3. **Why?** It is simpler to implement, less prone to "ghost characters," and modern terminals handle it so fast there is no flickering.

## TDD Progress Log

## Visual State Rendering: The Gallows

### 1. The Problem
The game state, specifically `remainingLives`, was only represented as a number. To create the classic Hangman experience, we need a strong visual indicator of how close the player is to losing.

### 2. The Solution: A Static View Class
A new class, `HangmanGallows`, was created to encapsulate the visual representation of the gallows.
- **Responsibility:** Its sole job is to map a game state (`remainingLives`) to a specific multi-line string of ASCII art.
- **Implementation:** It holds a `static const` list of the 7 visual stages of the hangman. A static method, `getGraphicForLives(int lives)`, provides the correct string.
- **Why Static?** The gallows art is constant and the class holds no state of its own, making it a perfect candidate for static members. This avoids the need to instantiate a `HangmanGallows` object in the main game loop.

### 3. TDD Approach
This component was developed via TDD. Tests were written to confirm that the `getGraphicForLives` method correctly returns the expected ASCII art for the start (6 lives), end (0 lives), and intermediate states, as well as handling invalid input gracefully by throwing a `RangeError`. This ensures the view logic is correct and decoupled from the main game engine.

## Dynamic Word Generation from a Dictionary

### 1. The Problem
A hardcoded `secretWord` makes the game predictable and boring after a single playthrough. To enhance replayability, the game must source its words from a larger, external collection.

### 2. The Solution: A `WordGenerator` Class
To keep the main game logic clean and adhere to the **I/O Separation** principle, we've introduced a dedicated `WordGenerator` class with a clear responsibility:
- **Load:** Read a dictionary file (`assets/words.txt`) from the filesystem.
- **Filter:** Process the raw list to include only words that meet specific criteria (e.g., >= 7 letters, alphabet-only characters). This ensures game quality.
- **Provide:** Offer a simple method (`getRandomWord()`) to supply a random, valid word to the `HangmanGame`.

### 3. Asynchronous Initialization
File I/O is an asynchronous operation in Dart. To handle this, the application's `main` function was converted to `async`. The game now follows this startup sequence:
1.  `main()` starts.
2.  `await wordGenerator.initialize()` is called. The program pauses here until the file is read and the word list is prepared.
3.  If successful, a random word is fetched.
4.  The `HangmanGame` is instantiated with the dynamic word.
5.  The game loop begins.

This approach ensures the game doesn't start until it has a valid word to play with, and it gracefully handles potential errors like a missing dictionary file.

## TDD Progress Log

### Cycle 1: Foundation & Guarding
- **Objective:** Initialize game state and validate terminal environment.
- **Why:** Ensuring the environment is safe (Dimension Guarding) and the game state is consistent before any logic is applied.

### Cycle 2: Guessing Logic
- **Objective:** Implement core "Update" rules (lives, guess tracking).
- **Why:** To verify the "Brain" of the game independently of the UI. Focuses on state transitions.

### Cycle 3: Case Insensitivity
- **Objective:** Normalize all input to uppercase.
- **Why:** User experience (UX) improvement. Prevents "false negative" guesses based on character case.

### Cycle 4: Masked Word Logic
- **Objective:** Transform the secret word into a displayable string (e.g., `_ A _ T`).
- **Why:** Core visual mechanic. Allows the user to see their progress without revealing the whole word.

### Cycle 5: Dynamic Word Generation
- **Objective:** Replace the hardcoded secret word with one randomly selected from a filtered dictionary file.
- **Why:** To make the game replayable and introduce the concept of asynchronous file I/O during game initialization.

### Cycle 6: Gallows Graphic
- **Objective:** To visually represent the player's remaining lives using ASCII art.
- **Why:** This is a core, iconic feature of Hangman that provides immediate, intuitive feedback to the player on their progress and proximity to losing the game.
