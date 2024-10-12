import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recruitment_test_website/core/base/state.dart';
import 'package:recruitment_test_website/features/quiz/presentation/pages/quiz_page.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({
    super.key,
    required this.size,
    required this.state,
    required this.index,
  });

  final ui.Size size;
  final BaseState state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (
        BuildContext context,
        WidgetRef ref,
        Widget? child,
      ) {
        return Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(
            bottom: size.height * .01,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: state.data[index].type == 'mcq'
              ? McqWidget(
                  questionEntity: state.data[index],
                  size: size,
                  totalQuestion: 5,
                  questionNumber: index,
                )
              : state.data[index].type == 'true false'
                  ? TrueFalseWidget(
                      questionEntity: state.data[index],
                      size: size,
                      totalQuestion: 5,
                      questionNumber: index,
                    )
                  : state.data[index].type == 'multiple answer'
                      ? MultipleAnswerWidget(
                          questionEntity: state.data[index],
                          size: size,
                          totalQuestion: 5,
                          questionNumber: index,
                        )
                      : Container(),
        );
      },
    );
  }
}
