import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/base/state.dart';
import 'package:recruitment_test_website/features/quiz/presentation/riverpods/question_notifier.dart';

final questionProvider = NotifierProvider<QuestionNotifier, BaseState>(
  QuestionNotifier.new,
);
