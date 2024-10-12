import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/features/quiz/domain/entities/question_entity.dart';
import 'package:recruitment_test_website/features/quiz/domain/repositories/quiz_repositories.dart';

final allQuizUseCaseProvider = Provider<AllQuizUseCase>(
  (ref) {
    final repository = ref.read(quizRepositoryProvider);

    return AllQuizUseCase(repository: repository);
  },
);

class AllQuizUseCase {
  AllQuizUseCase({required this.repository});

  final QuizRepository repository;

  Future<(String, List<QuestionEntity>?)> call() {
    return repository.getQuestion();
  }
}
