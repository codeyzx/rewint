// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:quizzle/configs/themes/app_colors.dart';
// import 'package:quizzle/screens/alphabet/alphabet_test.dart';
// import 'package:quizzle/screens/alphabet/alphabet_uppercase.dart';
// // ignore_for_file: prefer_const_constructors

// class AlphabetCategoryPage extends StatefulWidget {
//   const AlphabetCategoryPage({Key? key}) : super(key: key);

//   static const String routeName = '/alphabet-category';

//   @override
//   State<AlphabetCategoryPage> createState() => _AlphabetCategoryPageState();
// }

// class _AlphabetCategoryPageState extends State<AlphabetCategoryPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorMain,
//       body: Container(
//         width: 1.sw,
//         height: 1.sh,
//         decoration: BoxDecoration(
//           color: colorMain,
//           image: DecorationImage(
//             image: AssetImage('assets/images/mode-bg.png'),
//             fit: BoxFit.fill,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: 26.w,
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: Container(
//                     width: 35.w,
//                     height: 35.h,
//                     decoration: BoxDecoration(
//                         shape: BoxShape.circle, color: Colors.white),
//                     child: Center(
//                       child: Icon(
//                         Icons.arrow_back,
//                         color: HexColor('#F24E1E'),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 65.w,
//                 ),
//                 Text(
//                   'Pilih Mode!',
//                   style: pageTitle,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 124.h,
//             ),
//             Center(
//               child: InkWell(
//                 onTap: () {
//                   Get.toNamed(AlphabetUpperPage.routeName);

//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //       builder: (context) =>
//                   //           AlphabetUpperPage(),
//                   //     ));
//                 },
//                 child: Container(
//                   width: 249.w,
//                   height: 100.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Huruf Besar',
//                       style: modeTitle,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 35.h,
//             ),
//             Center(
//               child: InkWell(
//                 onTap: () {
//                   Get.toNamed(AlphabetTestScreen.routeName);
//                 },
//                 child: Container(
//                   width: 249.w,
//                   height: 100.h,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Huruf Kecil',
//                       style: modeTitle,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quizzle/configs/themes/app_colors.dart';
import 'package:quizzle/screens/alphabet/alphabet_screen.dart';

class AlphabetCategoryPage extends StatelessWidget {
  const AlphabetCategoryPage({Key? key}) : super(key: key);

  static const String routeName = '/alphabet-category';

  @override
  Widget build(BuildContext context) {
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
                height: 124.h,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AlphabetScreen.routeName, arguments: {
                      'isUpperCase': true,
                      'isWords': false,
                    });
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
                        'Huruf Besar',
                        style: modeTitle,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 35.h,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Get.toNamed(AlphabetScreen.routeName, arguments: {
                      'isUpperCase': false,
                      'isWords': false,
                    });
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
                        'Huruf Kecil',
                        style: modeTitle,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
