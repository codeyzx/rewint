import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rewint/controllers/controllers.dart';
import 'package:rewint/firebase/references.dart';
import 'package:rewint/models/models.dart' show QuizPaperModel, RecentTest;
import 'package:rewint/models/shop_model.dart';
import 'package:rewint/services/firebase/firebasestorage_service.dart';
import 'package:rewint/utils/logger.dart';

class ProfileController extends GetxController {
  @override
  void onReady() {
    getMyRecentTests();
    shopObs.bindStream(shopListen());
    points.bindStream(userListen());
    videoAccess.bindStream(videoAccessListen());
    super.onReady();
  }

  final shopObs = <ShopModel>[].obs;
  final allRecentTest = <RecentTest>[].obs;
  final shopData = <ShopModel>[].obs;
  Rx<int> users = 0.obs;
  Rx<int> points = 0.obs;
  Rx<int> videoAccess = 0.obs;

  Stream<List<ShopModel>> shopListen() {
    Stream<QuerySnapshot> stream =
        FirebaseFirestore.instance.collection('shop').snapshots();

    return stream.map((qShot) => qShot.docs
        .map((doc) => ShopModel(
            id: doc.get('id'),
            title: doc.get('title'),
            duration: doc.get('duration'),
            videoUrl: doc.get('videoUrl'),
            hasAccess: doc.get('hasAccess'),
            price: doc.get('price')))
        .toList());
  }

  Stream<int> userListen() {
    User? user = Get.find<AuthController>().getUser();

    if (user != null && !user.isAnonymous) {
      final Stream<DocumentSnapshot<Map<String, dynamic>>> collection =
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.email)
              .snapshots();
      return collection.map((event) => event.data()!['point'] as int);
    } else {
      return Stream.value(0);
    }
  }

  Stream<int> videoAccessListen() {
    User? user = Get.find<AuthController>().getUser();

    if (user != null && !user.isAnonymous) {
      final Stream<DocumentSnapshot<Map<String, dynamic>>> collection =
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.email)
              .snapshots();
      return collection.map((event) => event.data()!['videoAccess'] as int);
    } else {
      return Stream.value(0);
    }
  }

  buyVideo(String docId, String email, int userPoint, int videoPoint,
      List<dynamic> emailAccess) async {
    final shopCol = FirebaseFirestore.instance.collection('shop');
    final userCol = FirebaseFirestore.instance.collection('users');

    if (userPoint >= videoPoint) {
      try {
        await userCol.doc(email).update({
          'point': FieldValue.increment(-videoPoint),
          'videoAccess': FieldValue.increment(1),
        });

        emailAccess.add(email);

        await shopCol.doc(docId).update({'hasAccess': emailAccess});
      } catch (e) {
        AppLogger.e(e);
      }
    }
  }

  getMyRecentTests() async {
    User? user = Get.find<AuthController>().getUser();
    if (user != null && !user.isAnonymous) {
      try {
        FirebaseFirestore colRef = FirebaseFirestore.instance;
        final collection =
            await colRef.collection('users').doc(user.email).get();
        final dataPoint = collection.data();
        final tempPoints = dataPoint?['point'];
        users.value = tempPoints.toInt();

        QuerySnapshot<Map<String, dynamic>> data =
            await recentQuizes(userId: user.email!).get();

        final tests =
            data.docs.map((paper) => RecentTest.fromSnapshot(paper)).toList();

        for (RecentTest test in tests) {
          DocumentSnapshot<Map<String, dynamic>> quizPaperSnaphot =
              await quizePaperFR.doc(test.paperId).get();
          final quizPaper = QuizPaperModel.fromSnapshot(quizPaperSnaphot);

          final url = await Get.find<FireBaseStorageService>()
              .getImage(quizPaper.title);
          test.papername = quizPaper.title;
          test.paperimage = url;
        }

        allRecentTest.assignAll(tests);
      } catch (e) {
        AppLogger.e(e);
      }
    }
  }
}
