import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/features/quiz/data/data_sources/quiz_data_source.dart';
import 'package:recruitment_test_website/features/quiz/data/repositories/quiz_repositories_impl.dart';
import 'package:recruitment_test_website/features/quiz/domain/entities/question_entity.dart';

final quizRepositoryProvider = Provider<QuizRepositoryImp>(
  (ref) {
    final dataSource = ref.read(quizDataSourceProvider);

    return QuizRepositoryImp(dataSource: dataSource);
  },
);

abstract class QuizRepository {
  Future<(String, List<QuestionEntity>?)> getQuestion();
}
