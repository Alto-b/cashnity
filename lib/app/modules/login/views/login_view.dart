import 'package:cashnity/app/modules/home/views/widgets/glass_container.dart';
import 'package:cashnity/app/routes/app_pages.dart';
import 'package:cashnity/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.offAllNamed(Routes.HOME);
      }),
      body: Obx(
        () => Container(
          width: Get.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: (controller.themeController.isDark.value)
                  ? AppColors.scaffoldBGDark
                  : AppColors.scaffoldBGLight,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: controller.isLoginView.value
                      ? _loginView(context)
                      : _signUpView(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

GlassContainer _loginView(BuildContext context) {
  final controller = Get.find<LoginController>();
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final Color textColor = isDarkMode ? Colors.white : Colors.black87;

  return GlassContainer(
    key: const ValueKey('login'),
    borderRadius: BorderRadius.circular(24),
    blur: 20,
    child: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(24),
        height: Get.height * 0.60,
        width: Get.width * 0.80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back 👋",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              "Login to your account",
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 28),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateLoginForm()) {
                    controller.login(controller.emailController.text.trim(),
                        controller.passwordController.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () => controller.isLoginView.value = false,
                child: const Text.rich(
                  TextSpan(
                    text: "New here? ",
                    style: TextStyle(color: Colors.white70),
                    children: [
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

GlassContainer _signUpView(BuildContext context) {
  final controller = Get.find<LoginController>();
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final Color textColor = isDarkMode ? Colors.white : Colors.black87;

  return GlassContainer(
    key: const ValueKey('signup'),
    borderRadius: BorderRadius.circular(24),
    blur: 20,
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: Get.width * 0.80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Account 📝",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sign up to get started!",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                hintText: "Name",
                prefixIcon: const Icon(Icons.person_outline),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                TextField(
                  controller: controller.occupationController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Enter or select occupation',
                    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                    filled: true,
                    fillColor:
                        isDarkMode ? Colors.grey[850] : Colors.transparent,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    prefixIcon:
                        Icon(Icons.work_outline_rounded, color: textColor),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down, color: textColor),
                      color: isDarkMode ? Colors.grey[900] : Colors.white,
                      onSelected: (String value) {
                        controller.occupationController.text = value;
                      },
                      itemBuilder: (BuildContext context) {
                        return controller.occupationList
                            .map((String choice) => PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                ))
                            .toList();
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Confirm Password",
                prefixIcon: const Icon(Icons.lock_reset),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 28),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateSignUpForm()) {
                    controller.signUp(
                        name: controller.nameController.text.trim(),
                        email: controller.emailController.text.trim(),
                        password: controller.passwordController.text.trim(),
                        employmentStatus:
                            controller.occupationController.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () => controller.isLoginView.value = true,
                child: const Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: TextStyle(color: Colors.white70),
                    children: [
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: Colors.deepPurpleAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
