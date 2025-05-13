import 'package:cashnity/app/services/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final themeController = Get.find<ThemeController>();
  //variables for UI switch between
  RxBool isLoginView = true.obs;

  // Text Controllers
  final nameController = TextEditingController();
  final occupationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //lists for dropdown
  final occupationList = [
    'Full-time',
    'Part-time',
    'Freelancer',
    'Student',
    'Unemployed',
    'Other',
  ];

  // Form validation
  bool validateSignUpForm() {
    final name = nameController.text.trim();
    final occupation = occupationController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // Check all required fields at once
    if ([name, occupation, email, password, confirmPassword]
        .any((e) => e.isEmpty)) {
      Get.snackbar("Missing Fields", "Please fill out all fields.");
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.");
      return false;
    }

    if (password.length < 6) {
      Get.snackbar("Weak Password", "Password must be at least 6 characters.");
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar("Password Mismatch", "Passwords do not match.");
      return false;
    }

    return true;
  }

  void toggleView() {
    isLoginView.value = !isLoginView.value;
  }

  @override
  void onClose() {
    nameController.dispose();
    occupationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
