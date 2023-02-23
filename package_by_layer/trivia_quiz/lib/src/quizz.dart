import 'package:collection/collection.dart';

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
