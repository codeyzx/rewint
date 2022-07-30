import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rewint/configs/themes/app_colors.dart';
import 'package:rewint/screens/home/home_page.dart';
import 'package:rewint/widgets/common/circle_button.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);
  static const String routeName = '/introduction';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient(context)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: EasySeparatedColumn(
            separatorBuilder: (context, index) => const SizedBox(
              height: 40,
            ),
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_sharp,
                size: 65,
                color: kOnSurfaceTextColor,
              ),
              const Text(
                'This is not a production app. This quiz app is made for beginner flutter developers to understand the firebase integrations, state management, and the app flow. There are free available all source codes, design files also.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    color: kOnSurfaceTextColor,
                    fontWeight: FontWeight.bold),
              ),
              CircularButton(
                  onTap: () => Get.offAndToNamed(HomePage.routeName),
                  // onTap: () => Get.offAndToNamed(HomeScreen.routeName),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 35,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
