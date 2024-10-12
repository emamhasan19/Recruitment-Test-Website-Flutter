part of '../pages/quiz_page.dart';

class MultipleAnswerWidget extends ConsumerStatefulWidget {
  const MultipleAnswerWidget({
    required this.questionEntity,
    required this.size,
    required this.totalQuestion,
    required this.questionNumber,
    Key? key,
  }) : super(key: key);

  final QuestionEntity questionEntity;
  final Size size;
  final int totalQuestion;
  final int questionNumber;

  @override
  _MultipleAnswerWidgetState createState() => _MultipleAnswerWidgetState();
}

class _MultipleAnswerWidgetState extends ConsumerState<MultipleAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(answerProvider.notifier);

    final String imageSource = widget.questionEntity.imageLink ?? '';

    return Padding(
      padding: EdgeInsets.all(widget.size.width * .02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'QUESTION ${widget.questionNumber + 1} OF ${widget.totalQuestion}',
            style: GoogleFonts.nunito(
              color: UIColors.gray,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: widget.size.height * .01),
          imageSource.isNotEmpty
              ? Image.network(
                  imageSource,
                  scale: 1,
                )
              : Container(),
          SizedBox(height: widget.size.height * .01),
          Text(
            widget.questionEntity.question,
            style: GoogleFonts.nunito(
              color: UIColors.black,
              fontWeight: FontWeight.bold,
              fontSize: widget.size.height * .025,
            ),
          ),
          SizedBox(height: widget.size.height * .02),
          Column(
            children: [
              MultipleOptionWidget(
                value: notifier.answersList[widget.questionNumber] != null &&
                        notifier.answersList[widget.questionNumber]!
                            .contains(widget.questionEntity.options![0])
                    ? true
                    : false,
                onChanged: (value) {
                  notifier.selectedMultipleAnswer(
                      widget.questionNumber, widget.questionEntity.options![0]);
                  setState(() {
                    // widget.questionEntity.options[0] = value!;
                  });
                },
                label: widget.questionEntity.options![0],
              ),
              MultipleOptionWidget(
                value: notifier.answersList[widget.questionNumber] != null &&
                        notifier.answersList[widget.questionNumber]!
                            .contains(widget.questionEntity.options![1])
                    ? true
                    : false,
                onChanged: (value) {
                  notifier.selectedMultipleAnswer(
                      widget.questionNumber, widget.questionEntity.options![1]);
                  setState(() {});
                },
                label: widget.questionEntity.options![1],
              ),
              MultipleOptionWidget(
                value: notifier.answersList[widget.questionNumber] != null &&
                        notifier.answersList[widget.questionNumber]!
                            .contains(widget.questionEntity.options![2])
                    ? true
                    : false,
                onChanged: (value) {
                  notifier.selectedMultipleAnswer(
                      widget.questionNumber, widget.questionEntity.options![2]);
                  setState(() {});
                },
                label: widget.questionEntity.options![2],
              ),
              MultipleOptionWidget(
                value: notifier.answersList[widget.questionNumber] != null &&
                        notifier.answersList[widget.questionNumber]!
                            .contains(widget.questionEntity.options![3])
                    ? true
                    : false,
                onChanged: (value) {
                  notifier.selectedMultipleAnswer(
                      widget.questionNumber, widget.questionEntity.options![3]);
                  setState(() {});
                },
                label: widget.questionEntity.options![3],
              ),
            ],
          ),
          SizedBox(height: widget.size.height * .02),
        ],
      ),
    );
  }
}
