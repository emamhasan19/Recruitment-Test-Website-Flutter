import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recruitment_test_website/core/base/state.dart';
import 'package:recruitment_test_website/core/services/routes/routes.dart';
import 'package:recruitment_test_website/core/theme/colors.dart';
import 'package:recruitment_test_website/core/utils/assets.dart';
import 'package:recruitment_test_website/core/widgets/button/button.dart';
import 'package:recruitment_test_website/features/quiz/domain/entities/question_entity.dart';
import 'package:recruitment_test_website/features/quiz/presentation/pages/widgets/question_view.dart';
import 'package:recruitment_test_website/features/quiz/presentation/pages/widgets/terminated_view.dart';
import 'package:recruitment_test_website/features/quiz/presentation/pages/widgets/timer_view.dart';
import 'package:recruitment_test_website/features/quiz/presentation/pages/widgets/waiting_view.dart';
import 'package:recruitment_test_website/features/quiz/presentation/riverpods/answer_notifierr.dart';
import 'package:recruitment_test_website/features/quiz/presentation/riverpods/answer_provider.dart';
import 'package:recruitment_test_website/features/quiz/presentation/riverpods/question_provider.dart';
import 'package:recruitment_test_website/features/quiz/presentation/widgets/multiple_options_widget.dart';
import 'package:recruitment_test_website/features/quiz/presentation/widgets/options_widget.dart';

part '../widgets/mcq_widget.dart';
part '../widgets/multiple_answers_widget.dart';
part '../widgets/true_false_question_widget.dart';

class QuizPage extends ConsumerStatefulWidget {
  final int duration;
  final String sessionId;
  final String userId;
  const QuizPage({
    super.key,
    required this.duration,
    required this.sessionId,
    required this.userId,
  });

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  final CountDownController _controller = CountDownController();
  final GlobalKey _key = GlobalKey();

  late Timer screenshotTimer;
  late Timer tabChangeDetectionTimer;
  bool isQuizVisible = false;
  bool isScreenRecording = false;
  bool isVideoRecording = false;
  bool isWaiting = true;

  @override
  void initState() {
    super.initState();
    Future(initializationQuestion);
    startScreenshotTimer();
    startTabDetectionTimer();
    startScreenRecording();
    startVideoRecording();
  }

  @override
  void dispose() {
    screenshotTimer.cancel();
    tabChangeDetectionTimer.cancel();
    super.dispose();
  }

  Future<void> initializationQuestion() async {
    await ref.read(questionProvider.notifier).getQuestion();
  }

  void onBothConditionMet() {
    setState(() {
      isWaiting = false;
      isQuizVisible = true;
    });
  }

  void startScreenshotTimer() {
    screenshotTimer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer timer) {
        _captureAndUploadScreenshot();
      },
    );
  }

  Future<void> _captureAndUploadScreenshot() async {
    final BuildContext? currentContext = _key.currentContext;

    if (currentContext == null) {
      return;
    }

    final RenderRepaintBoundary? boundary =
        currentContext.findRenderObject() as RenderRepaintBoundary?;

    if (boundary == null) {
      return;
    }

    final ui.Image image = await boundary.toImage(pixelRatio: 2);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    final ref = firebase_storage.FirebaseStorage.instance.ref(
        '/${widget.userId}/screenshots/${DateTime.now().millisecondsSinceEpoch}');

    await ref.putData(Uint8List.fromList(pngBytes));
  }

  void startTabDetectionTimer() {
    tabChangeDetectionTimer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        final result = js.context.callMethod('detectTabChange');
        if (result == 'hidden') {
          if (mounted) {
            stopVideoRecording();
            stopScreenRecording();
            setState(() {
              isQuizVisible = false;
              timer.cancel();
              tabChangeDetectionTimer.cancel();
              screenshotTimer.cancel();
            });
          }
        }
      },
    );
  }

  void startScreenRecording() {
    js.context.callMethod('startScreenRecording',
        [_onScreenOrVideoSharingEnd, onBothConditionMet]);

    isScreenRecording = true;
  }

  void _onScreenOrVideoSharingEnd() {
    stopScreenRecording();
    stopVideoRecording();
    setState(() {
      isQuizVisible = false;
    });
  }

  void stopScreenRecording() async {
    if (isScreenRecording) {
      await js.context
          .callMethod('stopScreenRecording', [_handleScreenRecordingData]);
      isScreenRecording = false;
    } else {
      debugPrint('Recording is not started.');
    }
  }

  void _handleScreenRecordingData(dynamic recordedData) async {
    if (recordedData != null) {
      Uint8List videoData = await _blobToUint8List(recordedData);
      uploadVideoToFirebase(videoData, 'screenRecord');
    } else {
      debugPrint('Recorded data is null.');
    }
  }

  Future<Uint8List> _blobToUint8List(dynamic blob) async {
    final reader = html.FileReader();
    final completer = Completer<Uint8List>();

    reader.onLoadEnd.listen((html.ProgressEvent event) {
      completer.complete(Uint8List.fromList(reader.result as List<int>));
    });

    reader.readAsArrayBuffer(blob);

    return completer.future;
  }

  void startVideoRecording() {
    js.context.callMethod('startVideoRecording',
        [_onScreenOrVideoSharingEnd, onBothConditionMet]);
    isVideoRecording = true;
  }

  void stopVideoRecording() async {
    if (isVideoRecording) {
      await js.context
          .callMethod('stopVideoRecording', [_handleVideoRecordingData]);
      isVideoRecording = false;
    } else {
      debugPrint('Recording is not started.');
    }
  }

  void _handleVideoRecordingData(dynamic videoData) async {
    if (videoData != null) {
      Uint8List videoBytes = await _blobToUint8List(videoData);
      uploadVideoToFirebase(videoBytes, 'videoRecord');
    } else {
      debugPrint('Video recording data is null.');
    }
  }

  void uploadVideoToFirebase(Uint8List videoData, String videoType) async {
    Reference ref;
    if (videoType == 'screenRecord') {
      ref = firebase_storage.FirebaseStorage.instance.ref(
          '/${widget.userId}/screen-record-${DateTime.now().millisecondsSinceEpoch}.webm');
    } else {
      ref = firebase_storage.FirebaseStorage.instance.ref(
          '/${widget.userId}/video-record-${DateTime.now().millisecondsSinceEpoch}.webm');
    }

    await ref.putData(videoData);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = ref.watch(questionProvider);
    final answerNotifier = ref.read(answerProvider.notifier);

    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          ref.read(answerProvider.notifier).answersList.clear();
        }
      },
      child: RepaintBoundary(
        key: _key,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Scaffold(
              backgroundColor: UIColors.purple,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: size.height * .025),
                  child: isWaiting
                      ? WaitingView(size: size)
                      : isQuizVisible
                          ? Column(
                              children: [
                                TimerView(
                                    widget: widget, controller: _controller),
                                SizedBox(height: size.height * .05),
                                state.status == BaseStatus.loading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : state.status == BaseStatus.failure
                                        ? Text(
                                            'Error fetching data: ${state.error}',
                                          )
                                        : state.status == BaseStatus.success
                                            ? Center(
                                                child: SizedBox(
                                                  width: size.width * .5,
                                                  child: Column(
                                                    children: [
                                                      ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        itemCount:
                                                            state.data?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return QuestionView(
                                                            size: size,
                                                            state: state,
                                                            index: index,
                                                          );
                                                        },
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () =>
                                                            _handleSubmit(
                                                                context,
                                                                answerNotifier),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              UIColors.purple,
                                                          backgroundColor:
                                                              UIColors.white,
                                                          minimumSize: Size(
                                                            size.width * 0.15,
                                                            50,
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Submit',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const Text(
                                                "Something went wrong",
                                              ),
                              ],
                            )
                          : const TerminatedView(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool> _showConfirmDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Confirm Submission',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.6,
            child: const Text(
              'Are you sure you want to submit your exam?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleSubmit(
      BuildContext context, AnswerNotifier answerNotifier) async {
    bool submitConfirmed = await _showConfirmDialog(context);

    if (submitConfirmed) {
      int totalMark = answerNotifier.calculateTotalMark();

      FirebaseFirestore.instance
          .collection('leaderboard')
          .doc(widget.userId)
          .update({
        'mark': totalMark,
      });

      stopScreenRecording();
      stopVideoRecording();

      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.congratulation,
        (Route<dynamic> route) => false,
      );
    }
  }
}
