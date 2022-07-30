import 'package:flutter/material.dart';
import 'package:rewint/configs/configs.dart';
import 'package:rewint/widgets/widgets.dart';

class QuizNumberCard extends StatelessWidget {
  const QuizNumberCard(
      {Key? key,
      required this.index,
      required this.status,
      required this.onTap,
      required this.isQuizScreen})
      : super(key: key);

  final int index;
  final AnswerStatus? status;
  final bool isQuizScreen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor = Theme.of(context).primaryColor;

    switch (status) {
      case AnswerStatus.answered:
        _backgroundColor = Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        _backgroundColor = kCorrectAnswerColor;
        break;
      case AnswerStatus.wrong:
        _backgroundColor = kWrongAnswerColor;
        break;
      case AnswerStatus.notanswered:
        _backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
        break;
      default:
        _backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }

    return isQuizScreen
        ? InkWell(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.51),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  '$index',
                  style: questionNumber,
                ),
              ),
            ),
          )
        // InkWell(
        //     borderRadius: UIParameters.cardBorderRadius,
        //     onTap: onTap,
        //     child: InkWell(
        //       child: Center(
        //         child: Text('$index',
        //             style: GoogleFonts.poppins(
        //               color: status == AnswerStatus.notanswered
        //                   ? Colors.green
        //                   : Colors.red,
        //             )),
        //       ),
        //     ),
        //   )
        : InkWell(
            borderRadius: UIParameters.cardBorderRadius,
            onTap: onTap,
            child: Ink(
              child: Center(
                child: Text(
                  '$index',
                  style: kQuizeNumberCardTs.copyWith(
                      color: status == AnswerStatus.notanswered
                          ? Theme.of(context).primaryColor
                          : null),
                ),
              ),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: _backgroundColor,
                  borderRadius: UIParameters.cardBorderRadius),
            ),
          );
  }
}
