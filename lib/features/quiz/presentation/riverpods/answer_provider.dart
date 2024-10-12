import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/base/state.dart';
import 'package:recruitment_test_website/features/quiz/presentation/riverpods/answer_notifierr.dart';

final answerProvider = NotifierProvider<AnswerNotifier, BaseState>(
  AnswerNotifier.new,
);
