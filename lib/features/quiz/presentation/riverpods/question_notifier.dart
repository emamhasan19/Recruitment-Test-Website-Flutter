import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/base/state.dart';
import 'package:recruitment_test_website/core/utils/loggers/logger.dart';
import 'package:recruitment_test_website/features/quiz/domain/use_cases/quiz_use_case.dart';
import 'package:recruitment_test_website/features/quiz/presentation/riverpods/answer_provider.dart';

class QuestionNotifier extends Notifier<BaseState> {
  late final AllQuizUseCase _allQuizUseCase;
  @override
  BaseState build() {
    _allQuizUseCase = ref.read(allQuizUseCaseProvider);
    return const BaseState();
  }

  Future<void> getQuestion() async {
    Log.debug('came to getQuestion method in notifier');
    state = state.copyWith(
      status: BaseStatus.loading,
    );
    try {
      final response = await _allQuizUseCase.call();

      state = state.copyWith(
        status: BaseStatus.success,
        data: response.$2,
      );
      ref
          .read(answerProvider.notifier)
          .initializeAnswersList(response.$2!.length);
      ref
          .read(answerProvider.notifier)
          .initializeCorrectAnswersList(response.$2!.length, response.$2!);
    } catch (e) {
      state = state.copyWith(
        status: BaseStatus.failure,
        error: e.toString(),
      );
    }
  }
}
