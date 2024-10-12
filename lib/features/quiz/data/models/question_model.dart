import 'package:recruitment_test_website/features/quiz/domain/entities/question_entity.dart';

class QuestionModel extends QuestionEntity {
  QuestionModel({
    required super.question,
    required super.correctAnswer,
    required super.options,
    required super.sessionId,
    required super.type,
    this.imageLink,
  });

  String? imageLink;

  factory QuestionModel.fromFirebase(Map<String, dynamic> json) {
    return QuestionModel(
      correctAnswer: json['correct_answer'],
      imageLink: json['image'],
      options: json['options'],
      question: json['question'],
      sessionId: json['session_id'],
      type: json['type'],
    );
  }
}
