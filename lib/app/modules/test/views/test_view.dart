import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/test_controller.dart';

class TestView extends GetView<TestController> {
  const TestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollUpdateNotification) {
                final position = scrollNotification.metrics.pixels;
                // If the white container reaches the top, we stick it to the top
                if (position >= Get.height * 0.4 - (Get.height * 0.3 / 2)) {
                  controller.isSticky.value = true;
                  // Make the floating card disappear if it's at the top
                  if (position >= Get.height * 0.4) {
                    controller.isVisible.value = false;
                  } else {
                    controller.isVisible.value = true;
                  }
                } else {
                  controller.isSticky.value = false;
                  controller.isVisible.value = true;
                }
              }
              return true;
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: Get.height * 0.4,
                      width: Get.width,
                      color: Colors.red,
                    ),
                    Container(
                      height: Get.height * 0.8,
                      width: Get.width,
                      color: Colors.blue,
                    ),
                    Container(
                      height: Get.height * 0.8,
                      width: Get.width,
                      color: Colors.green,
                    ),
                  ],
                ),
                _floatingCard(
                    controller.isSticky.value, controller.isVisible.value),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _floatingCard(bool isSticky, bool isVisible) {
    if (!isVisible) {
      return const SizedBox.shrink(); // Hide the card when not visible
    }

    double scrollPosition = isSticky ? 60 : Get.height * 0.3;

    return Positioned(
      top: isSticky
          ? 0
          : Get.height * 0.4 - (Get.height * 0.3 / 2), // Stick to top if true
      left: 16,
      right: 16,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: scrollPosition,
        width: Get.width - 32,
        color: Colors.white,
        child: isSticky
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'AppBar Title',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : const Center(
                child: Text(
                  'White Box',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
