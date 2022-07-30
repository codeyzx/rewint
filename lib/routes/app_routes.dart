import 'package:get/get.dart';
import 'package:rewint/controllers/controllers.dart';
import 'package:rewint/screens/alphabet/alphabet_category.dart';
import 'package:rewint/screens/alphabet/alphabet_screen.dart';
import 'package:rewint/screens/handwriting/handwriting_screen.dart';
import 'package:rewint/screens/home/home_page.dart';
import 'package:rewint/screens/image_guess/image_guess_category_screen.dart';
import 'package:rewint/screens/math/math_category_screen.dart';
import 'package:rewint/screens/object_detection/object_detector_view.dart';
import 'package:rewint/screens/screens.dart';
import 'package:rewint/screens/word/word_category_screen.dart';
import 'package:rewint/screens/word/word_spell_screen.dart';
import 'package:rewint/widgets/botnavbar.dart';

class AppRoutes {
  static List<GetPage> pages() => [
        GetPage(
          page: () => const ObjectDetectionScreen(),
          name: ObjectDetectionScreen.routeName,
        ),
        GetPage(
          page: () => const BotNavBar(),
          name: BotNavBar.routeName,
          binding: BindingsBuilder(() {
            Get.put(QuizPaperController());
            Get.put(MyDrawerController());
            Get.put(ProfileController());
          }),
        ),
        GetPage(
          page: () => const HandwritingScreen(),
          name: HandwritingScreen.routeName,
        ),
        GetPage(
          page: () => const AlphabetCategoryPage(),
          name: AlphabetCategoryPage.routeName,
        ),
        GetPage(
          page: () => const AlphabetScreen(),
          name: AlphabetScreen.routeName,
        ),
        GetPage(
          page: () => const WordCategoryScreen(),
          name: WordCategoryScreen.routeName,
        ),
        GetPage(
          page: () => const WordSpellScreen(),
          name: WordSpellScreen.routeName,
        ),
        GetPage(
          page: () => const MathCategoryScreen(),
          name: MathCategoryScreen.routeName,
        ),
        GetPage(
          page: () => const ImageGuessCategoryScreen(),
          name: ImageGuessCategoryScreen.routeName,
        ),
        GetPage(
          page: () => const SplashScreen(),
          name: SplashScreen.routeName,
        ),
        GetPage(
          page: () => const AppIntroductionScreen(),
          name: AppIntroductionScreen.routeName,
        ),
        GetPage(
            page: () => const HomePage(),
            name: HomePage.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(MyDrawerController());
            })),
        GetPage(
            page: () => const HomeScreen(),
            name: HomeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(MyDrawerController());
            })),
        GetPage(page: () => const LoginScreen(), name: LoginScreen.routeName),
        GetPage(
            page: () => const ProfileScreen(),
            name: ProfileScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(QuizPaperController());
              Get.put(ProfileController());
            })),
        GetPage(
            page: () => LeaderBoardScreen(),
            name: LeaderBoardScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put(LeaderBoardController());
            })),
        GetPage(
            page: () => const QuizeScreen(),
            name: QuizeScreen.routeName,
            binding: BindingsBuilder(() {
              Get.put<QuizController>(QuizController());
            })),
        GetPage(
            page: () => const AnswersCheckScreen(),
            name: AnswersCheckScreen.routeName),
        GetPage(
            page: () => const QuizOverviewScreen(),
            name: QuizOverviewScreen.routeName),
        GetPage(page: () => const Resultcreen(), name: Resultcreen.routeName),
      ];
}
