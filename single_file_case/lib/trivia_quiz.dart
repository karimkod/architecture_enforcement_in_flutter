library quiz_service;

import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;

class QuizzService {
  final _QuizRepository _quizRepository;

  QuizzService._internal(this._quizRepository);

  Future<Quizz> getRandomQuizz() async {
    return await _quizRepository.getRandomQuizz();
  }
}

class Quizz {
  final String question;
  final Map<int, String> suggestions;
  final int correctAnswerIndex;

  Quizz(
      {required this.question,
      required this.suggestions,
      required this.correctAnswerIndex});

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is Quizz &&
          other.question == question &&
          other.correctAnswerIndex == correctAnswerIndex &&
          const DeepCollectionEquality().equals(other.suggestions, suggestions);

  @override
  int get hashCode =>
      question.hashCode ^
      correctAnswerIndex.hashCode ^
      Object.hashAll(suggestions.values);
}

abstract class _QuizRepository {
  Future<Quizz> getRandomQuizz();
}

class _FakeRepository extends _QuizRepository {
  @override
  Future<Quizz> getRandomQuizz() {
    return Future.value(Quizz(
        question: "Where is Algeria Situated?",
        suggestions: {
          0: "North Africa",
          1: "South Africa",
          2: "Eastern Europe",
          3: "South America"
        },
        correctAnswerIndex: 0));
  }
}

class _TriviaRepository extends _QuizRepository {
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

QuizzService testCompose() {
  return QuizzService._internal(_FakeRepository());
}

QuizzService compose() {
  return QuizzService._internal(_TriviaRepository());
}
