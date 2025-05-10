import 'package:cashnity/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    _proceedToHome();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> _proceedToHome() async {
    await Future.delayed(Duration(seconds: 3));
    // await Get.offAllNamed(Routes.HOME);
    await Get.offAllNamed(Routes.LOGIN);
  }
}
