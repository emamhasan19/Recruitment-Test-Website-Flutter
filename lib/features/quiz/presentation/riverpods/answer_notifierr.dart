import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/base/state.dart';
import 'package:recruitment_test_website/features/quiz/domain/entities/question_entity.dart';

class AnswerNotifier extends Notifier<BaseState> {
  Map<int, List> answersList = {};
  Map<int, List> correctAnswersList = {};
  @override
  build() {
    return const BaseState();
  }

  void initializeAnswersList(int length) {
    answersList = {
      for (var index in List.generate(
        length,
        (index) => index,
      ))
        index: [],
    };
  }

  void initializeCorrectAnswersList(
      int length, List<QuestionEntity> allQuestion) {
    for (int i = 0; i < allQuestion.length; i++) {
      correctAnswersList[i] = allQuestion[i].correctAnswer!;
    }
  }

  void selectedMcqAnswer(int index, String answer) {
    List tmpAnswer = answersList[index] ?? [];

    if (tmpAnswer.contains(answer)) {
      tmpAnswer.remove(answer);
    } else {
      tmpAnswer = [answer];
    }

    answersList[index] = tmpAnswer;

    state = state.copyWith(
      data: answersList,
      status: BaseStatus.success,
    );
  }

  void selectedMultipleAnswer(int index, String answer) {
    List tmpAnswer = answersList[index] ?? [];

    if (tmpAnswer.contains(answer)) {
      tmpAnswer.remove(answer);
    } else {
      tmpAnswer.add(answer);
    }

    answersList[index] = tmpAnswer;

    state = state.copyWith(
      data: answersList,
      status: BaseStatus.success,
    );
  }

  int calculateTotalMark() {
    int totalMarks = 0;

    for (int index = 0; index < answersList.length; index++) {
      List? userAnswer = answersList[index];

      for (int i = 0; i < correctAnswersList[index]!.length; i++) {
        if (!userAnswer!.contains(correctAnswersList[index]![i])) {
          totalMarks -= 10;
          break;
        }
      }

      totalMarks += 10;
    }

    return totalMarks;
  }
}
