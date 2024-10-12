part of '../pages/quiz_page.dart';

class TrueFalseWidget extends ConsumerStatefulWidget {
  const TrueFalseWidget({
    super.key,
    required this.questionEntity,
    required this.size,
    required this.totalQuestion,
    required this.questionNumber,
  });

  final QuestionEntity questionEntity;
  final Size size;
  final int totalQuestion;
  final int questionNumber;

  @override
  ConsumerState<TrueFalseWidget> createState() => _TrueFalseWidgetState();
}

class _TrueFalseWidgetState extends ConsumerState<TrueFalseWidget> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(answerProvider.notifier);
    final state = ref.watch(answerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            Assets.trueFalseImage,
            scale: 1.5,
          ),
        ),
        SizedBox(height: widget.size.height * .02),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.size.width * .02),
          child: Text(
            'QUESTION ${widget.questionNumber + 1} OF ${widget.totalQuestion}',
            style: GoogleFonts.nunito(
              color: UIColors.gray,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: widget.size.height * .01),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.size.width * .02),
          child: Text(
            widget.questionEntity.question,
            style: GoogleFonts.nunito(
              color: UIColors.black,
              fontWeight: FontWeight.w800,
              fontSize: widget.size.height * .022,
            ),
          ),
        ),
        SizedBox(height: widget.size.height * .02),
        widget.size.width >= 360
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Button(
                    label: widget.questionEntity.options![0],
                    textStyle: GoogleFonts.nunito(
                      color: UIColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: widget.size.width * .02,
                    ),
                    width: widget.size.width * .2,
                    background:
                        notifier.answersList[widget.questionNumber] != null &&
                                notifier.answersList[widget.questionNumber]!
                                    .contains(widget.questionEntity.options![0])
                            ? widget.questionEntity.options![0] == 'false'
                                ? UIColors.red
                                : UIColors.pineGreen
                            : widget.questionEntity.options![0] == 'false'
                                ? UIColors.red.withOpacity(0.3)
                                : UIColors.pineGreen.withOpacity(0.3),
                    height: widget.size.height * .062,
                    onPressed: () {
                      notifier.selectedMcqAnswer(
                        widget.questionNumber,
                        widget.questionEntity.options![0],
                      );
                    },
                  ),
                  Button(
                    label: widget.questionEntity.options![1],
                    textStyle: GoogleFonts.nunito(
                      color: UIColors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: widget.size.width * .02,
                    ),
                    width: widget.size.width * .2,
                    height: widget.size.height * .062,
                    background:
                        notifier.answersList[widget.questionNumber] != null &&
                                notifier.answersList[widget.questionNumber]!
                                    .contains(widget.questionEntity.options![1])
                            ? widget.questionEntity.options![1] == 'false'
                                ? UIColors.red
                                : UIColors.pineGreen
                            : widget.questionEntity.options![1] == 'false'
                                ? UIColors.red.withOpacity(0.3)
                                : UIColors.pineGreen.withOpacity(0.3),
                    onPressed: () {
                      notifier.selectedMcqAnswer(
                        widget.questionNumber,
                        widget.questionEntity.options![1],
                      );
                    },
                  ),
                ],
              )
            : buildColumnForSmallScreen(notifier),
        SizedBox(height: widget.size.height * .02)
      ],
    );
  }

  Column buildColumnForSmallScreen(AnswerNotifier notifier) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Button(
          label: widget.questionEntity.options![0],
          textStyle: GoogleFonts.nunito(
            color: UIColors.white,
            fontWeight: FontWeight.w800,
            fontSize: widget.size.width * .04,
          ),
          background: notifier.answersList[widget.questionNumber] != null &&
                  notifier.answersList[widget.questionNumber]!
                      .contains(widget.questionEntity.options![0])
              ? widget.questionEntity.options![0] == 'false'
                  ? UIColors.red
                  : UIColors.pineGreen
              : widget.questionEntity.options![0] == 'false'
                  ? UIColors.red.withOpacity(0.3)
                  : UIColors.pineGreen.withOpacity(0.3),
          height: widget.size.height * .062,
          onPressed: () {
            notifier.selectedMcqAnswer(
              widget.questionNumber,
              widget.questionEntity.options![0],
            );
            setState(() {});
          },
        ),
        SizedBox(height: widget.size.height * .02),
        Button(
          label: widget.questionEntity.options![1],
          textStyle: GoogleFonts.nunito(
            color: UIColors.white,
            fontWeight: FontWeight.w800,
            fontSize: widget.size.width * .04,
          ),
          height: widget.size.height * .062,
          background: notifier.answersList[widget.questionNumber] != null &&
                  notifier.answersList[widget.questionNumber]!
                      .contains(widget.questionEntity.options![1])
              ? widget.questionEntity.options![1] == 'false'
                  ? UIColors.red
                  : UIColors.pineGreen
              : widget.questionEntity.options![1] == 'false'
                  ? UIColors.red.withOpacity(0.3)
                  : UIColors.pineGreen.withOpacity(0.3),
          onPressed: () {
            notifier.selectedMcqAnswer(
              widget.questionNumber,
              widget.questionEntity.options![1],
            );
            setState(() {});
          },
        ),
      ],
    );
  }
}
