import 'package:cashnity/app/services/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final themeController = Get.find<ThemeController>();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController expenseTypeController = TextEditingController();
  final List<String> incomeTypes = [
    '💼 Salary',
    '📈 Investments',
    '🎁 Gifts',
    '🛒 Freelance',
    '🏦 Interest',
    '💸 Bonus',
    '📤 Refund',
  ];
  final List<String> expenseTypes = [
    '🍔 Food',
    '✈️ Travel',
    '🛍 Shopping',
    '💡 Bills',
    '🏠 Rent',
    '🎉 Entertainment',
    '💊 Health',
    '🎓 Education',
    '🚗 Transport',
  ];
}
