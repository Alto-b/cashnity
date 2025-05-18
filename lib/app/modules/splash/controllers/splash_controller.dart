import 'package:cashnity/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final GetStorage storage = GetStorage();

  RxBool isUserLoggedin = false.obs;
  @override
  @override
  void onInit() {
    super.onInit();

    isUserLoggedin.value = storage.read('userLoggedInStatus') ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isUserLoggedin.value) {
        _proceedToHome();
      } else {
        _proceedToLogin();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> proceed() async {
    if (isUserLoggedin.value) {
      _proceedToHome();
    } else {
      _proceedToLogin();
    }
  }

  Future<void> _proceedToHome() async {
    await Get.offAllNamed(Routes.HOME);
  }

  Future<void> _proceedToLogin() async {
    await Get.offAllNamed(Routes.LOGIN);
  }
}
