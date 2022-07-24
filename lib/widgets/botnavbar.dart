import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quizzle/configs/configs.dart';
// import 'package:quizzle/screens/auth_and_profile/profile_screen.dart';
import 'package:quizzle/screens/home/home_page.dart';
import 'package:quizzle/screens/profile/profile_screen.dart';
import 'package:quizzle/screens/shop/shop_screen.dart';
// ignore_for_file: prefer_const_constructors

class BotNavBar extends StatefulWidget {
  const BotNavBar({Key? key}) : super(key: key);

  static const String routeName = '/botnavbar';

  @override
  State<BotNavBar> createState() => _BotNavBarState();
}

class _BotNavBarState extends State<BotNavBar> {
  int currentIndex = 0;

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 62.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = HomePage();
                    currentIndex = 0;
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      currentIndex == 0
                          ? 'assets/images/home-nav-active.png'
                          : 'assets/images/home-nav-off.png',
                      width: 30.w,
                      height: 30.h,
                    ),
                    Text(
                      'Home',
                      style: currentIndex == 0 ? navSelected : navUnSelected,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = ShopScreen();
                    // currentScreen = HomeScreen();
                    currentIndex = 1;
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      currentIndex == 1
                          ? 'assets/images/shop-active.png'
                          : 'assets/images/shop-inactive.png',
                      width: 30.w,
                      height: 30.h,
                    ),
                    Text(
                      'Shop',
                      style: currentIndex == 1 ? navSelected : navUnSelected,
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = ProfileScreenYangBener();
                    currentIndex = 2;
                  });
                },
                minWidth: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      currentIndex == 2
                          ? 'assets/images/profile-active.png'
                          : 'assets/images/profile-inactive.png',
                      width: 30.w,
                      height: 30.h,
                    ),
                    Text(
                      'Profile',
                      style: currentIndex == 2 ? navSelected : navUnSelected,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
