import 'package:get/get.dart';
import 'package:rewint/controllers/controllers.dart';
import 'package:rewint/services/services.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController());
    //Get.put(PapersDataUploader());
    Get.put(AuthController(), permanent: true);
    Get.put(NotificationService());
    Get.lazyPut(() => FireBaseStorageService());
  }
}
