part of '../pages/quiz_page.dart';

class McqWidget extends ConsumerStatefulWidget {
  const McqWidget({
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
  ConsumerState<McqWidget> createState() => _McqWidgetState();
}

class _McqWidgetState extends ConsumerState<McqWidget> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(answerProvider.notifier);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Padding(
          padding: EdgeInsets.all(widget.size.width * .02),
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'QUESTION ${widget.questionNumber + 1} OF ${widget.totalQuestion}',
                  style: GoogleFonts.nunito(
                    color: UIColors.gray,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: widget.size.height * .01),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.questionEntity.question,
                  style: GoogleFonts.nunito(
                    color: UIColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.size.height * .025,
                  ),
                ),
              ),
              SizedBox(height: widget.size.height * .02),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      notifier.selectedMcqAnswer(widget.questionNumber,
                          widget.questionEntity.options![0]);
                      setState(() {});
                    },
                    child: OptionsWidget(
                      isClicked: notifier.answersList[widget.questionNumber] !=
                                  null &&
                              notifier.answersList[widget.questionNumber]!
                                  .contains(widget.questionEntity.options![0])
                          ? true
                          : false,
                      options: widget.questionEntity.options![0],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      notifier.selectedMcqAnswer(widget.questionNumber,
                          widget.questionEntity.options![1]);
                      setState(() {});
                    },
                    child: OptionsWidget(
                      isClicked: notifier.answersList[widget.questionNumber] !=
                                  null &&
                              notifier.answersList[widget.questionNumber]!
                                  .contains(widget.questionEntity.options![1])
                          ? true
                          : false,
                      options: widget.questionEntity.options![1],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      notifier.selectedMcqAnswer(widget.questionNumber,
                          widget.questionEntity.options![2]);
                      setState(() {});
                    },
                    child: OptionsWidget(
                      isClicked: notifier.answersList[widget.questionNumber] !=
                                  null &&
                              notifier.answersList[widget.questionNumber]!
                                  .contains(widget.questionEntity.options![2])
                          ? true
                          : false,
                      options: widget.questionEntity.options![2],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      notifier.selectedMcqAnswer(widget.questionNumber,
                          widget.questionEntity.options![3]);
                      setState(() {});
                    },
                    child: OptionsWidget(
                      isClicked: notifier.answersList[widget.questionNumber] !=
                                  null &&
                              notifier.answersList[widget.questionNumber]!
                                  .contains(widget.questionEntity.options![3])
                          ? true
                          : false,
                      options: widget.questionEntity.options![3],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
