import 'dart:io';
import 'dart:math';

/// A utility to load and provide random words from a dictionary file.
class WordGenerator {
  final String filePath;
  final List<String> _words = [];
  final _random = Random();

  static final _alphaOnly = RegExp(r'^[a-zA-Z]+$');

  /// Creates a WordGenerator that will read from [filePath].
  WordGenerator({required this.filePath});

  /// Reads the word file, filters it, and prepares it for use.
  ///
  /// This must be called before [getRandomWord].
  /// It filters for words that are 7+ letters and contain only A-Z characters.
  Future<void> initialize() async {
    try {
      final file = File(filePath);
      final lines = await file.readAsLines();

      _words.clear(); // Clear any previous words
      _words.addAll(lines.where((word) {
        return word.length >= 7 && _alphaOnly.hasMatch(word);
      }));

      if (_words.isEmpty) {
        throw Exception('No valid words found in the dictionary file that meet the criteria (>= 7 letters, alpha-only).');
      }
    } on FileSystemException {
      // Re-throw with a more user-friendly message
      throw FileSystemException('Dictionary file not found.', filePath);
    }
  }

  /// Returns a random word from the loaded and filtered list.
  String getRandomWord() {
    if (_words.isEmpty) {
      throw StateError('WordGenerator has not been initialized or the word list is empty.');
    }
    return _words[_random.nextInt(_words.length)];
  }
}