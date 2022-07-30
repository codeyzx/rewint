import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rewint/controllers/controllers.dart';
import 'package:rewint/firebase/references.dart';

extension QuizeResult on QuizController {
  int get correctQuestionCount => allQuestions
      .where((question) => question.selectedAnswer == question.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (quizPaperModel.timeSeconds - remainSeconds) /
        quizPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveQuizResults() async {
    var batch = fi.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null || _user.email == null || _user.isAnonymous) {
      return navigateToHome();
    }

    batch.set(
        userFR
            .doc(_user.email)
            .collection('myrecent_quizes')
            .doc(quizPaperModel.id),
        {
          "points": points,
          "correct_count": '$correctQuestionCount/${allQuestions.length}',
          "paper_id": quizPaperModel.id,
          "time": quizPaperModel.timeSeconds - remainSeconds
        });
    batch.set(
        leaderBoardFR
            .doc(quizPaperModel.id)
            .collection('scores')
            .doc(_user.email),
        {
          "points": double.parse(points),
          "correct_count": '$correctQuestionCount/${allQuestions.length}',
          "paper_id": quizPaperModel.id,
          "user_id": _user.email,
          "time": quizPaperModel.timeSeconds - remainSeconds
        });
    await batch.commit();
    // Get.find<NotificationService>().showQuizCompletedNotification(
    //     id: 1,
    //     title: quizPaperModel.title,
    //     body:
    //         'You have just got $points points for ${quizPaperModel.title} -  Tap here to view leaderboard',
    //     imageUrl: quizPaperModel.imageUrl,
    //     payload: json.encode(quizPaperModel.toJson()));
    navigateToHome();
  }
}
