import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/base/state.dart';
import 'package:recruitment_test_website/features/recruitment_sessions/presentation/riverpods/recruitment_sessions_notifier.dart';

final recruitmentSessionsProvider =
    NotifierProvider<RecruitmentSessionsNotifier, BaseState>(
  RecruitmentSessionsNotifier.new,
);
