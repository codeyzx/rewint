import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rewint/configs/configs.dart';
import 'package:rewint/controllers/auth_controller.dart';
import 'package:rewint/controllers/profile/profile_controller.dart';
import 'package:rewint/screens/video/video_screen.dart';

class ShopScreen extends GetView<ProfileController> {
  final bool unlocked = false;

  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _auth = Get.find<AuthController>();
    final email = _auth.getUser()?.email;
    return Scaffold(
      backgroundColor: colorMain,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: BoxDecoration(
          color: colorMain,
          image: const DecorationImage(
            image: AssetImage('assets/images/shop-bg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              floating: false,
              pinned: false,
              snap: false,
              expandedHeight: 145.h,
              backgroundColor: HexColor('#FFFACA'),
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.r),
                  bottomRight: Radius.circular(40.r),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 29.h,
                    ),
                    Text(
                      'Total Point Kamu',
                      style: sliverTitle,
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Container(
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
                          Obx(
                            () => Text(
                              '${controller.points.value} Points',
                              style: profileTotalPoint,
                              textAlign: TextAlign.center,
                            ),
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
                    SizedBox(
                      height: 7.h,
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
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 29.w, right: 29.w),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.shopObs.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.shopObs[index].hasAccess!
                                          .contains(email) ==
                                      true
                                  ? Get.to(VideoScreen(
                                      videoUrl:
                                          controller.shopObs[index].videoUrl!,
                                    ))
                                  : _auth.getUser()?.isAnonymous == true ||
                                          _auth.getUser() == null
                                      ? AwesomeDialog(
                                          context: context,
                                          animType: AnimType.LEFTSLIDE,
                                          headerAnimationLoop: false,
                                          dialogType: DialogType.ERROR,
                                          showCloseIcon: true,
                                          title: 'Login terlebih dahulu!!',
                                          desc:
                                              'Untuk membeli video kamu perlu login terlebih dahulu ya',
                                          btnOkOnPress: () {
                                            debugPrint('OnClcik');
                                          },
                                          btnOkIcon: Icons.check_circle,
                                          onDissmissCallback: (type) {
                                            debugPrint(
                                                'Dialog Dissmiss from callback $type');
                                          },
                                        ).show()
                                      : AwesomeDialog(
                                          context: context,
                                          animType: AnimType.LEFTSLIDE,
                                          headerAnimationLoop: false,
                                          dialogType: DialogType.INFO_REVERSED,
                                          showCloseIcon: true,
                                          title:
                                              'Beli video ${controller.shopObs[index].title}?',
                                          desc:
                                              'Harga ${controller.shopObs[index].price} Points',
                                          btnOkOnPress: () {
                                            debugPrint('OnClcik');
                                            controller.buyVideo(
                                                controller.shopObs[index].id!,
                                                _auth.getUser()!.email!,
                                                controller.points.value,
                                                controller
                                                    .shopObs[index].price!,
                                                controller
                                                    .shopObs[index].hasAccess!);
                                          },
                                          btnOkIcon: Icons.check_circle,
                                          onDissmissCallback: (type) {
                                            debugPrint(
                                                'Dialog Dissmiss from callback $type');
                                          },
                                        ).show();
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: 10.h,
                                  bottom: 10.h,
                                  left: 13.w,
                                  right: 13.w),
                              width: 295.w,
                              height: 70.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        HexColor('#588200').withOpacity(0.25),
                                    blurRadius: 5,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 37.w,
                                        height: 37.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black
                                                  .withOpacity(0.20),
                                              blurRadius: 7,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/play-vid-big.png',
                                            width: 26.w,
                                            height: 26.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.shopObs[index].title
                                                .toString(),
                                            // 'Cocomelon',
                                            style: videoTitle,
                                          ),
                                          Text(
                                            controller.shopObs[index].duration
                                                .toString(),
                                            // '2 Menit 10 Detik',
                                            style: videoDuration,
                                          ),
                                          SizedBox(
                                            height: 3.h,
                                          ),
                                          Container(
                                            width: 75.w,
                                            height: 13.h,
                                            decoration: BoxDecoration(
                                              color: colorMain,
                                              borderRadius:
                                                  BorderRadius.circular(4.r),
                                            ),
                                            child: Center(
                                                child: Text(
                                              '${controller.shopObs[index].price} Points',
                                              style: videoCost,
                                            )),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 44.w,
                                    height: 44.h,
                                    decoration: BoxDecoration(
                                      color: controller
                                                  .shopObs[index].hasAccess!
                                                  .contains(email) ==
                                              true
                                          ? HexColor('#BBF21E')
                                          : HexColor('#F24E1E'),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.20),
                                          blurRadius: 7,
                                          spreadRadius: 4,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: controller
                                                  .shopObs[index].hasAccess!
                                                  .contains(email) ==
                                              true
                                          ? Image.asset(
                                              'assets/images/lock-open.png',
                                              width: 24.w,
                                              height: 24.h,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.asset(
                                              'assets/images/lock-close.png',
                                              width: 24.w,
                                              height: 24.h,
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
