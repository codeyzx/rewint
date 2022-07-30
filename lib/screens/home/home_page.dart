import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rewint/configs/themes/app_colors.dart';
import 'package:rewint/controllers/quiz_paper/quiz_papers_controller.dart';
import 'package:rewint/screens/alphabet/alphabet_category.dart';
import 'package:rewint/screens/image_guess/image_guess_category_screen.dart';
import 'package:rewint/screens/math/math_category_screen.dart';
import 'package:rewint/screens/object_detection/object_detector_view.dart';
import 'package:rewint/screens/word/word_category_screen.dart';
import 'package:rewint/screens/word/word_spell_screen.dart';

class HomePage extends GetView<QuizPaperController> {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/home-page';

  @override
  Widget build(BuildContext context) {
    Color containerColor = HexColor('#251ABE').withOpacity(0.25);
    Color eclipseColor = HexColor('#FAFCA2').withOpacity(0.65);

    return Scaffold(
      backgroundColor: HexColor('#251ABE'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          Center(
            child: Text(
              'Pilih Permainan!',
              style: pageTitle,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            width: 323.w,
            height: 467.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.20),
                  blurRadius: 14,
                  spreadRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 22.h),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(AlphabetCategoryPage.routeName);
                          },
                          child: Container(
                            width: 127.w,
                            height: 127.h,
                            decoration: BoxDecoration(
                              color: HexColor('#2E294E').withOpacity(0.25),
                              borderRadius: BorderRadius.circular(13.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.20),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  width: 55.w,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        HexColor('#2E294E').withOpacity(0.67),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/belajar_huruf.png',
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  'Belajar Huruf',
                                  style: categoryTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(WordCategoryScreen.routeName);
                          },
                          child: Container(
                            width: 127.w,
                            height: 127.h,
                            decoration: BoxDecoration(
                              color: HexColor('#329F5B').withOpacity(0.25),
                              borderRadius: BorderRadius.circular(13.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.20),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  width: 55.w,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        HexColor('#329F5B').withOpacity(0.67),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/belajar_kata.png',
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  'Belajar Kata',
                                  style: categoryTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(MathCategoryScreen.routeName);
                          },
                          child: Container(
                            width: 127.w,
                            height: 127.h,
                            decoration: BoxDecoration(
                              color: HexColor('#FF0000').withOpacity(0.25),
                              borderRadius: BorderRadius.circular(13.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.20),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  width: 55.w,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        HexColor('#FF0000').withOpacity(0.26),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/matematika.png',
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  'Matematika',
                                  style: categoryTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(ImageGuessCategoryScreen.routeName);
                          },
                          child: Container(
                            width: 127.w,
                            height: 127.h,
                            decoration: BoxDecoration(
                              color: HexColor('#03CEA4').withOpacity(0.25),
                              borderRadius: BorderRadius.circular(13.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.20),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  width: 55.w,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        HexColor('#03CEA4').withOpacity(0.67),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/tebak_gambar.png',
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  'Tebak gambar',
                                  style: categoryTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            // Get.offAllNamed(HomeScreen.routeName);
                            Get.toNamed(WordSpellScreen.routeName,
                                arguments: false);
                          },
                          child: Container(
                            width: 127.w,
                            height: 127.h,
                            decoration: BoxDecoration(
                              color: HexColor('#19297C').withOpacity(0.25),
                              borderRadius: BorderRadius.circular(13.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.20),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  width: 55.w,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        HexColor('#19297C').withOpacity(0.25),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/mengeja.png',
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.h,
                                ),
                                Text(
                                  'Mengeja',
                                  style: categoryTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(ObjectDetectionScreen.routeName);
                          },
                          child: Container(
                            width: 127.w,
                            height: 127.h,
                            decoration: BoxDecoration(
                              color: HexColor('#EAC435').withOpacity(0.25),
                              borderRadius: BorderRadius.circular(13.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.20),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  width: 55.w,
                                  height: 55.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        HexColor('#EAC435').withOpacity(0.67),
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      'assets/images/mengenal_lingkungan.png',
                                      width: 50.w,
                                      height: 50.h,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Text(
                                  'Mengenal Lingkungan',
                                  style: categoryTitle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const ProfileScreen(),
          //         ));
          //   },
          //   child: const Text('Profile Screen'),
          // ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const ShopScreen(),
          //         ));
          //   },
          //   child: const Text('Shop Screen'),
          // ),
        ],
      ),
      // bottomNavigationBar: BotNavBar(),
    );
  }
}
