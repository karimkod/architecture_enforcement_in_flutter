import 'quizz.dart';
import 'quizz_repository.dart';

class QuizzService {
  final QuizRepository _quizRepository;

  QuizzService(this._quizRepository);

  Future<Quizz> getRandomQuizz() async {
    return await _quizRepository.getRandomQuizz();
  }
}
