import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:quizzle/configs/configs.dart';
import 'package:quizzle/controllers/auth_controller.dart';
import 'package:quizzle/controllers/profile/profile_controller.dart';

class ProfileScreenYangBener extends GetView<ProfileController> {
  const ProfileScreenYangBener({Key? key}) : super(key: key);

  static const String routeName = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fprofits = FirebaseFirestore.instance;

    final AuthController _auth = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: colorMain,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
          color: colorMain,
          image: const DecorationImage(
            image: AssetImage('assets/images/profile-bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70.h,
                ),
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Center(
                      child: _auth.getUser()?.photoURL == null
                          ? Image.asset(
                              'assets/images/robot.png',
                              width: 63.w,
                              height: 63.h,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              _auth.getUser()!.photoURL!,
                              width: 63.w,
                              height: 63.h,
                              fit: BoxFit.cover,
                            )),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  _auth.getUser()?.displayName ?? 'Anonymous',
                  style: profileName,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 21.w),
                  width: 1.sw,
                  height: 406.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.r),
                      topRight: Radius.circular(45.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 22.h,
                      ),
                      Center(
                        child: Text(
                          'Total Point',
                          style: profileSubTitle,
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Center(
                        child: Container(
                          width: 195.w,
                          height: 55.h,
                          decoration: BoxDecoration(
                            color: colorMain,
                            borderRadius: BorderRadius.circular(45.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _auth.getUser()?.email == null
                                    ? '0 Points'
                                    : '${controller.users.value} Points',
                                // '1000 Points',
                                style: profileTotalPoint,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Image.asset(
                                'assets/images/star.png',
                                width: 23.w,
                                height: 23.h,
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/Help.png',
                            width: 15.w,
                            height: 15.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            'dapatkan point dari bermain',
                            style: profileHelp,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 23.h,
                      ),
                      Text(
                        'Pencapaian',
                        style: profileSubTitle,
                      ),
                      SizedBox(
                        height: 13.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 5.h, left: 12.w, right: 12.w),
                            width: 147.w,
                            height: 109.h,
                            decoration: BoxDecoration(
                              color: HexColor('#FAFCA2'),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#00042D').withOpacity(0.15),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 21.w,
                                      height: 21.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.20),
                                            blurRadius: 3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/play-video.png',
                                          width: 17.w,
                                          height: 17.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 44.w,
                                      height: 15.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.20),
                                            blurRadius: 14,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Keren!',
                                          style: profileComm,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  '5/10',
                                  style: profileAchievNum,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  'Shop terbuka',
                                  style: profileAchievName,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                top: 5.h, left: 12.w, right: 12.w),
                            width: 147.w,
                            height: 109.h,
                            decoration: BoxDecoration(
                              color: HexColor('#FAFCA2'),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: HexColor('#00042D').withOpacity(0.15),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 21.w,
                                      height: 21.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.20),
                                            blurRadius: 3,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/math.png',
                                          width: 17.w,
                                          height: 17.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 44.w,
                                      height: 15.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.20),
                                            blurRadius: 14,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Keren!',
                                          style: profileComm,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  '${controller.allRecentTest.length}/10',
                                  style: profileAchievNum,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                Text(
                                  'Seluruh Quiz',
                                  style: profileAchievName,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
