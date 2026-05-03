# GEMINI Project Instructions: Hangman (Dart CLI)

This project is a CLI Hangman game built with Dart, following TDD and GSD (Get Shit Done) principles.

## Project Overview
- **Purpose:** A classic Hangman word-guessing game for the terminal.
- **Main Technologies:** Dart SDK 3.11.5.
- **Core Methodology:** Test-Driven Development (TDD) and GSD.

## GSD (Get Shit Done) Principles
- **Atomic Progress:** Focus on small, verifiable milestones.
- **Fail Fast:** Use TDD to identify issues immediately.
- **Lean Implementation:** Write only the code necessary to pass the current test.
- **Continuous Validation:** Every commit must pass all tests and linting.

## TDD Workflow
1. **Red:** Write a failing test for the smallest possible unit of logic.
2. **Green:** Write the minimal code to make the test pass.
3. **Refactor:** Clean up the code while keeping the test green.

## Git Workflow & Conventions
- **Main Branch:** `main` (Stable, production-ready code).
- **Feature Branches:** Use `feat/feature-name` for new work.
- **Commits:**
  - Commit after every "Green" phase or successful refactor.
  - Message format: `[Topic/Phase] Short description (e.g., [TDD: Green] Add word validation)`.
- **Changelog:** Update `CHANGELOG.md` with every milestone, including a timestamp.

## Custom Workflows
- **Update Concept:** When a valuable technical or architectural concept is discussed, or a TDD cycle is completed, use the keyword "update concept" to trigger its documentation in `CONCEPT.md`. This MUST include:
  - Technical rationale.
  - TDD Cycle summaries (Objective and Why).
  - Any architectural shifts.

## Building and Running
### Commands
- **Initialize Project:** `dart create . --force`
- **Install Dependencies:** `dart pub get`
- **Run the Project:** `dart run bin/hangman.dart`
- **Run Tests:** `dart test`
- **Linting:** `dart analyze`

## Project Structure (Planned)
- `bin/`: CLI entry point.
- `lib/`: Core game logic.
- `test/`: Unit and integration tests.

## Current Milestones
- [x] Environment Check ($DART_HOME: /opt/homebrew/Cellar/dart-sdk/3.11.5/libexec)
- [x] Git Initialization
- [x] Initial GEMINI.md & CHANGELOG.md
- [ ] Project Initialization (`dart create`)
- [ ] TDD Cycle 1: Game State Initialization
