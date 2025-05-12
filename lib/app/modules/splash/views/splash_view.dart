import 'package:cashnity/app_colors.dart';
import 'package:cashnity/media.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  final SplashController controller = Get.find();

  SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Media.wallet_bannerPng),
            CupertinoActivityIndicator(
              color: AppColors.loaderColor,
              radius: 12,
            )
          ],
        )),
      ),
    );
  }
}
