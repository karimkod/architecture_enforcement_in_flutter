import 'quizz_api_repository.dart';
import 'quizz_service.dart';

QuizzService compose() {
  return QuizzService(TriviaQuizRepository());
}
