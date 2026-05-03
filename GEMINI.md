# GEMINI Project Instructions: Hangman (Dart CLI)

This project is a Command Line Interface (CLI) Hangman game implemented using Dart, following Test-Driven Development (TDD) and Get Shit Done (GSD) principles.

## Project Overview
- **Purpose:** A classic Hangman word-guessing game for the terminal.
- **Main Technologies:** Dart.
- **Methodology:** TDD (Red-Green-Refactor) and GSD (focused, incremental delivery).
- **Learning Goal:** Interactive learning through the development process.

## Building and Running

### Prerequisites
- Dart SDK installed (Check `$DART_HOME`).

### Commands
- **Initialize Project:** `dart create --template=console-full .`
- **Install Dependencies:** `dart pub get`
- **Run the Project:** `dart run bin/main.dart`
- **Run Tests:** `dart test`
- **Linter/Analysis:** `dart analyze`

## Development & Git Workflow
- **TDD Flow:** Write a failing test -> Implementation -> Pass test -> Refactor.
- **GSD Approach:** Focus on small, actionable milestones. Don't over-engineer.
- **Git Strategy:** 
    - Main branch: `main` (stable).
    - Feature branches: `feat/feature-name` for new work.
    - Atomic commits: One commit per small milestone/logical change.
    - `CHANGELOG.md`: Updated with every significant milestone (with timestamps).

## Milestones (GSD)
1. [x] **Environment & Initial Setup:** Git init, project scaffolding, check Dart.
2. [x] **Core Logic (TDD):** Word selection, guess handling, win/loss conditions.
3. [ ] **CLI Interface:** User input, terminal output (ASCII art for hangman).
4. [ ] **Polish:** Error handling, replayability.

## Instruction for Gemini
- Be proactive in suggesting the next small TDD step.
- Explain the "why" behind Dart features or architectural choices to support the user's learning.
- Always verify changes with tests.
- Update `CHANGELOG.md` and commit after completing each sub-task.
