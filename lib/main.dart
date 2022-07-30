import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'bindings/initial_binding.dart';
import 'controllers/common/theme_controller.dart';
import 'firebase_options.dart';
import 'routes/app_routes.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFireBase();
  InitialBinding().dependencies();

  cameras = await availableCameras();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        builder: (context, child) {
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            title: 'Rewint',
            theme: Get.find<ThemeController>().getLightheme(),
            darkTheme: Get.find<ThemeController>().getDarkTheme(),
            getPages: AppRoutes.pages(),
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

Future<void> initFireBase() async {
  await Firebase.initializeApp(
    name: 'rewint',
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// void main(List<String> args) async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initFireBase();
//   runApp(GetMaterialApp(
//     home: DataUploaderScreen(),
//   ));
// }
