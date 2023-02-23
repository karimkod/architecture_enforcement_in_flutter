import 'quizz.dart';

abstract class QuizRepository {
  Future<Quizz> getRandomQuizz();
}
