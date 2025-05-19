import 'package:cashnity/app/core/services/storage_services.dart';
import 'package:cashnity/app/modules/login/controllers/login_controller.dart';
import 'package:cashnity/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final GetStorage storage = GetStorage();
  final StorageService storageService = StorageService();
  final loginController = Get.find<LoginController>();

  RxBool isUserLoggedin = false.obs;
  @override
  @override
  void onInit() {
    super.onInit();

    isUserLoggedin.value = storage.read('userLoggedInStatus') ?? false;
    final userId = storageService.getLoggedInUserId();

    if (isUserLoggedin.value && userId != null) {
      loginController.loadUserProfile(userId).then((_) {
        _proceedToHome();
      }).catchError((error) {
        _proceedToLogin();
      });
    } else {
      _proceedToLogin();
    }
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
