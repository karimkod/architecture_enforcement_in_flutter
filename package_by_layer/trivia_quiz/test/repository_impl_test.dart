import 'package:test/test.dart';
import 'package:trivia_quiz/src/quizz_api_repository.dart';

void main() 
{

  final TriviaQuizRepository sut = TriviaQuizRepository();

  test('Getting random question from Trivia API',
  () async { 
    
    var result = await sut.getRandomQuizz();
    expect(result.question, isNotEmpty);
    expect(result.question, endsWith("?"));
    expect(result.suggestions.length, equals(4));
    expect(result.suggestions.values, anyElement(isNotEmpty));
    expect(result.suggestions.keys, contains(result.correctAnswerIndex));

    });
}
