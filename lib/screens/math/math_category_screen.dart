import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rewint/configs/configs.dart';
import 'package:rewint/controllers/quiz_paper/quiz_papers_controller.dart';

class MathCategoryScreen extends GetView<QuizPaperController> {
  static const String routeName = '/math-category';

  const MathCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizPaperController _quizePprContoller = Get.find();

    return Scaffold(
      backgroundColor: colorMain,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
          color: colorMain,
          image: const DecorationImage(
            image: AssetImage('assets/images/mode-bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 26.w,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Container(
                    width: 35.w,
                    height: 35.h,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: HexColor('#F24E1E'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 65.w,
                ),
                Text(
                  'Pilih Mode!',
                  style: pageTitle,
                ),
              ],
            ),
            SizedBox(
              height: 62.h,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  controller.navigatoQuestions(
                      paper: _quizePprContoller.allPapers[0]);
                },
                child: Container(
                  width: 249.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      'Tambah (+)',
                      style: modeTitle,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  controller.navigatoQuestions(
                      paper: _quizePprContoller.allPapers[1]);
                },
                child: Container(
                  width: 249.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      'Kurang (-)',
                      style: modeTitle,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  controller.navigatoQuestions(
                      paper: _quizePprContoller.allPapers[2]);
                },
                child: Container(
                  width: 249.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      'Kali (x)',
                      style: modeTitle,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 13.h,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  controller.navigatoQuestions(
                      paper: _quizePprContoller.allPapers[3]);
                },
                child: Container(
                  width: 249.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      'Bagi (÷)',
                      style: modeTitle,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
