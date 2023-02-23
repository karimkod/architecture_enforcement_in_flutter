
import 'package:test/test.dart';
import 'package:trivia_quiz/src/quizz.dart';
import 'package:trivia_quiz/src/quizz_repository.dart';
import 'package:trivia_quiz/src/quizz_service.dart';


class FakeQuizRepository implements QuizRepository {
  late final Quizz randomQuizz;
  @override
  Future<Quizz> getRandomQuizz() async {
    await Future.delayed(Duration(milliseconds: 100));
    return randomQuizz; 
  }
  void initWithRanadomQuestionResult(Quizz quizz) => randomQuizz = quizz;
}

void main() {
  late final QuizzService sut;
  final Quizz expectedQuizz = Quizz(
        question: "Where is Algeria Situated?",
        suggestions: {
          0: "North Africa",
          1: "South Africa",
          2: "Eastern Europe",
          3: "South America"
        },
        correctAnswerIndex: 0);

  setUp(() {

    var repository = FakeQuizRepository();
    repository.initWithRanadomQuestionResult(expectedQuizz);
    sut = QuizzService(repository);
  });

  test('Get Random Quizz test', () async {

    var result = await sut.getRandomQuizz();
    expect(result, equals(expectedQuizz));
  });
}


