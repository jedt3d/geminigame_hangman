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
    - **Why?** It is simpler to implement, less prone to "ghost characters," and modern terminals handle it so fast there is no flickering.

    ### 4. CLI Entry Point Patterns
    The `main()` function in `bin/` acts as the orchestrator:
    1. **Guard:** Check environment (terminal size, dependencies).
    2. **Clear:** Reset the visual buffer to provide a clean state.
    3. **Init:** Create the game state object.
    4. **Render:** Perform the initial print of the state.

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
    - **Technical Rationale:** Spaces are added between characters (`_ _ _`) because consecutive underscores can appear as a single solid line in many terminal fonts, making it impossible for the player to count the letters.
    - **Status:** Complete (Green).

    ### Milestone: Bridge to CLI
    - **Objective:** Integrate logic into `bin/hangman.dart`.
    - **Why:** To verify that our theoretical "Brain" works in a real terminal "Body."

    ### Cycle 5: ASCII Gallows Rendering
    - **Objective:** Provide a visual representation of the player's remaining lives using ASCII art.
    - **Why:** Essential thematic element of Hangman. Provides immediate, high-signal feedback on the game's stakes.
    - **Technical Rationale:** We will use multi-line string literals (triple quotes in Dart) to store the gallows states, mapped to the `remainingLives` count.

pendently of the UI. Focuses on state transitions.

### Cycle 3: Case Insensitivity
- **Objective:** Normalize all input to uppercase.
- **Why:** User experience (UX) improvement. Prevents "false negative" guesses based on character case.
