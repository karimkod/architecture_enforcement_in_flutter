import 'package:flutter_test/flutter_test.dart';
import 'package:single_file_case/trivia_quiz.dart';

void main() {
  final QuizzService sut = testCompose();

  test('Get Random Quizz test', () async {
    var expectedQuizz = Quizz(
        question: "Where is Algeria Situated?",
        suggestions: {
          0: "North Africa",
          1: "South Africa",
          2: "Eastern Europe",
          3: "South America"
        },
        correctAnswerIndex: 0);

    var result = await sut.getRandomQuizz();
    expect(result, equals(expectedQuizz));
  });
}
