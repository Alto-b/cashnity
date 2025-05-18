import 'package:cashnity/app/core/services/storage_services.dart';
import 'package:cashnity/app/domain/entities/user_entity.dart';
import 'package:cashnity/app/domain/use_cases/get_profile_use_case.dart';
import 'package:cashnity/app/domain/use_cases/login_use_case.dart';
import 'package:cashnity/app/domain/use_cases/sign_up_use_case.dart';
import 'package:cashnity/app/routes/app_pages.dart';
import 'package:cashnity/app/services/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final SignUpUserUseCase signUpUserUseCase;
  final GetUserProfileUseCase getUserProfileUseCase;
  final LoginUseCase loginUseCase;
  LoginController(
      {required this.signUpUserUseCase,
      required this.getUserProfileUseCase,
      required this.loginUseCase});

  final storageService = Get.find<StorageService>();

  final Rxn<UserEntity> currentUser = Rxn<UserEntity>();
  RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;

  final themeController = Get.find<ThemeController>();
  //variables for UI switch between
  RxBool isLoginView = true.obs;

  // Text Controllers
  final nameController = TextEditingController();
  final occupationController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  void onInit() {
    bool isLoggedIn = storageService.isUserLoggedIn();
    super.onInit();
  }

  //lists for dropdown
  final occupationList = [
    'Full-time',
    'Part-time',
    'Freelancer',
    'Student',
    'Unemployed',
    'Other',
  ];
//Login Form validation
  bool validateLoginForm() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    // Check all required fields at once
    if ([
      email,
      password,
    ].any((e) => e.isEmpty)) {
      Get.snackbar("Missing Fields", "Please fill out all fields.");
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.");
      return false;
    }

    return true;
  }

  //Sign up Form validation
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

  Future<void> signUp(
      {required String name,
      required String email,
      required String password,
      required String employmentStatus}) async {
    isLoading.value = true;

    final newUser = UserEntity(
      id: '', // will be generated in repo
      name: name,
      email: email,
      password: password,
      employmentStatus: employmentStatus,
    );

    final result = await signUpUserUseCase(newUser, password);

    isLoading.value = false;

    if (result == "Success") {
      // navigate or show success
      Get.rawSnackbar(message: "Success");
      handleLoginSuccess();
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar("Error", result);
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    final result = await loginUseCase(email, password);
    isLoading.value = false;

    result.fold(
      (error) => errorMessage.value = error,
      (user) {
        currentUser.value = user;
        errorMessage.value = '';
        handleLoginSuccess();
        Get.offAllNamed(Routes.HOME);
      },
    );
  }

  void handleLoginSuccess() {
    storageService.setLoginStatus(true);
  }

  Future<void> loadUserProfile(String userId) async {
    isLoading.value = true;
    final user = await getUserProfileUseCase(userId);
    isLoading.value = false;

    if (user != null) {
      currentUser.value = user;
    } else {
      Get.snackbar("Error", "Failed to load user profile");
    }
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
