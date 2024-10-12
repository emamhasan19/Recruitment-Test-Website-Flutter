import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:recruitment_test_website/features/quiz/presentation/pages/quiz_page.dart';

class TimerView extends StatelessWidget {
  const TimerView({
    super.key,
    required this.widget,
    required CountDownController controller,
  }) : _controller = controller;

  final QuizPage widget;
  final CountDownController _controller;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: widget.duration,
      initialDuration: 0,
      controller: _controller,
      width: 200,
      height: 200,
      ringColor: Colors.grey[300]!,
      ringGradient: null,
      fillColor: Colors.purpleAccent[100]!,
      fillGradient: null,
      backgroundColor: Colors.purple[500],
      backgroundGradient: null,
      strokeWidth: 20.0,
      strokeCap: StrokeCap.round,
      textStyle: const TextStyle(
        fontSize: 33.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      textFormat: CountdownTextFormat.S,
      isReverse: true,
      isReverseAnimation: false,
      isTimerTextShown: true,
      autoStart: true,
      onStart: () {
        debugPrint('Countdown Started');
      },
      onComplete: () {
        debugPrint('Countdown Ended');
      },
      onChange: (String timeStamp) {
        debugPrint('Countdown Changed $timeStamp');
      },
      timeFormatterFunction: (defaultFormatterFunction, remainingTime) {
        final int hours = remainingTime.inHours;
        final int minutes = (remainingTime.inMinutes % 60);
        final int seconds = (remainingTime.inSeconds % 60);

        return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      },
    );
  }
}
