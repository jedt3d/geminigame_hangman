import 'package:hangman/gallows.dart';
import 'package:test/test.dart';

void main() {
  group('HangmanGallows', () {
    test('getGraphicForLives returns correct stage for full lives (6)', () {
      // Arrange
      const expectedStage = '''
   +---+
   |   |
       |
       |
       |
       |
=========''';

      // Act
      final graphic = HangmanGallows.getGraphicForLives(6);

      // Assert
      expect(graphic, expectedStage);
    });

    test('getGraphicForLives returns correct stage for zero lives (0)', () {
      // Arrange
      const expectedStage = '''
   +---+
   |   |
   O   |
  /|\\  |
  / \\  |
       |
=========''';

      // Act
      final graphic = HangmanGallows.getGraphicForLives(0);

      // Assert
      expect(graphic, expectedStage);
    });

    test('getGraphicForLives returns correct stage for 3 lives', () {
      // Arrange
      const expectedStage = '''
   +---+
   |   |
   O   |
  /|   |
       |
       |
=========''';

      // Act
      final graphic = HangmanGallows.getGraphicForLives(3);

      // Assert
      expect(graphic, expectedStage);
    });

    test('getGraphicForLives throws RangeError for invalid live counts', () {
      // Assert
      expect(() => HangmanGallows.getGraphicForLives(7), throwsA(isA<RangeError>()));
      expect(() => HangmanGallows.getGraphicForLives(-1), throwsA(isA<RangeError>()));
    });
  });
}