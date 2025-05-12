import 'package:cashnity/app/modules/home/views/widgets/glass_container.dart';
import 'package:cashnity/media.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  // You can use different transitions here
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: controller.isLoginView.value
                    ? _loginView()
                    : _signUpView(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

GlassContainer _loginView() {
  final controller = Get.find<LoginController>();
  return GlassContainer(
    key: const ValueKey('login'), // important for AnimatedSwitcher
    borderRadius: BorderRadius.circular(24),
    blur: 20,
    // opacity: 0.15,
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
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Login to your account",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 24),
          const TextField(
            decoration: InputDecoration(
              hintText: "Email",
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              filled: true,
              fillColor: Colors.white10,
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              filled: true,
              fillColor: Colors.white10,
            ),
          ),
          const SizedBox(height: 28),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Add login logic
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
              onPressed: () {
                controller.isLoginView.value = false;
              },
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
  );
}

GlassContainer _signUpView(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final Color textColor = isDarkMode ? Colors.white : Colors.black87;
  final controller = Get.find<LoginController>();
  return GlassContainer(
    key: const ValueKey('signup'), // Required for AnimatedSwitcher transitions
    borderRadius: BorderRadius.circular(24),
    blur: 20,

    child: Container(
      padding: const EdgeInsets.all(24),
      // height: Get.height * 0.65,
      width: Get.width * 0.80,
      child: SingleChildScrollView(
        // Handles keyboard overflow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Account 📝",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Sign up to get started!",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
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
                    fillColor: isDarkMode ? Colors.grey[850] : Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      // borderSide: BorderSide(color: Colors.grey)
                      // borderSide: BorderSide.none,
                    ),
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
                        return controller.occupationList.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
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
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
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
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
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
                prefixIcon: Icon(Icons.lock_reset),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                filled: true,
                fillColor: Colors.white10,
              ),
            ),
            const SizedBox(height: 28),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (controller.validateSignUpForm()) {
                    // Proceed with signup logic
                  } else {
                    //   Get.snackbar("Oops!", "Did you miss something");
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
                onPressed: () {
                  controller.isLoginView.value = true;
                },
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
