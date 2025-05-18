import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
          addExpenseUseCase: Get.find(), getExpensesUseCase: Get.find()),
    );
  }
}
