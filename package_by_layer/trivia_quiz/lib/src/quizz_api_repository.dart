import 'dart:convert';
import 'dart:io';

import 'package:trivia_quiz/src/quizz.dart';
import 'package:trivia_quiz/src/quizz_repository.dart';
import 'package:http/http.dart' as http;

class TriviaQuizRepository implements QuizRepository {
  static const String _url = "https://the-trivia-api.com/api/questions?limit=1";

  @override
  Future<Quizz> getRandomQuizz() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final singleQuizz = jsonResponse.first;
      String correctAnswer = singleQuizz['correctAnswer'];
      List<String> suggestions = [
        ...singleQuizz['incorrectAnswers'],
        correctAnswer
      ];
      return Quizz(
          correctAnswerIndex: suggestions.indexOf(correctAnswer),
          suggestions: suggestions.asMap(),
          question: singleQuizz['question']);
    }
    throw UnimplementedError();
  }
}
