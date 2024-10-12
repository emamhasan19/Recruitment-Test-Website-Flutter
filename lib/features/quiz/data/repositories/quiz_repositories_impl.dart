import 'package:recruitment_test_website/core/utils/loggers/logger.dart';
import 'package:recruitment_test_website/features/quiz/data/data_sources/quiz_data_source.dart';
import 'package:recruitment_test_website/features/quiz/data/models/question_model.dart';
import 'package:recruitment_test_website/features/quiz/domain/entities/question_entity.dart';
import 'package:recruitment_test_website/features/quiz/domain/repositories/quiz_repositories.dart';

class QuizRepositoryImp extends QuizRepository {
  QuizRepositoryImp({
    required this.dataSource,
  });

  final QuizDataSource dataSource;

  @override
  Future<(String, List<QuestionEntity>?)> getQuestion() async {
    try {
      List<Map<String, dynamic>> questionList = await dataSource.getQuestion();

      List<QuestionModel> allQuestionList = questionList
          .map((questionMap) => QuestionModel.fromFirebase(questionMap))
          .toList()
        ..forEach((question) => question.options!.shuffle());

      allQuestionList.shuffle();

      print(allQuestionList);
      print(allQuestionList.length);
      print('yes all good');

      return ("", allQuestionList);
    } catch (e, stackTrace) {
      Log.error('$e\n$stackTrace');
      return ("Error: $e", null);
    }
  }
}
