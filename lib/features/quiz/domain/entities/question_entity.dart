class QuestionEntity {
  QuestionEntity({
    required this.question,
    required this.correctAnswer,
    required this.sessionId,
    required this.type,
    this.imageLink,
    this.options,
  });
  final String question;
  List<dynamic>? correctAnswer;
  List<dynamic>? options;
  final String sessionId;
  final String type;
  String? imageLink;
}
