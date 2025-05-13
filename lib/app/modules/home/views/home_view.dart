import 'package:cashnity/app/modules/home/views/widgets/drawer.dart';
import 'package:cashnity/app/modules/home/views/widgets/glass_container.dart';
import 'package:cashnity/app/services/theme_controller.dart';
import 'package:cashnity/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../controllers/home_controller.dart';
import 'dart:ui';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;
    final Color subTextColor = isDarkMode ? Colors.white70 : Colors.black54;
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        drawer: HomeDrawer(),
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: (controller.themeController.isDark.value)
                    ? AppColors.scaffoldBGDark
                    : AppColors.scaffoldBGLight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GlassContainer(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _scaffoldKey.currentState?.openDrawer();
                                },
                                child: Icon(Icons.menu,
                                    color: (isDarkMode)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              const SizedBox(
                                  width: 24), // Placeholder for symmetry
                              _themeModeSwitch(),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Cashnity",
                                style: TextStyle(color: textColor),
                                // style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Gap(20),
                    _totalBalanceCard(textColor),
                    const Gap(20),
                    _editBalanceRow(textColor, isDarkMode),
                    const Gap(20),
                    _transactionHistoryList(context)
                    // Add more widgets below...
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  GlassContainer _transactionHistoryList(BuildContext context) {
    return GlassContainer(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Transactions",
              style: context.textTheme.titleLarge,
            ),
            Icon(Icons.filter_alt_outlined)
          ],
        ),
        Gap(5),
        ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.wallet_travel),
                ),
              ),
              title: Text(
                "data",
                style: context.textTheme.bodyLarge,
              ),
              subtitle: Text(
                "Apr ${index + 1}",
                style: context.textTheme.bodySmall,
              ),
              trailing: Text("\$110"),
            );
          },
        ),
        Gap(10)
      ],
    ));
  }

  Widget _editBalanceRow(Color textColor, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Add Income
          Expanded(
            child: GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: InkWell(
                onTap: () {
                  _openIncomeExpenseBottomSheet(isIncome: true, isDark: isDark);
                },
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline, color: textColor),
                    const SizedBox(width: 8),
                    Text(
                      'Add Income',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Add Expense
          Expanded(
            child: GlassContainer(
              borderRadius: BorderRadius.circular(16),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              child: InkWell(
                onTap: () {
                  _openIncomeExpenseBottomSheet(
                      isIncome: false, isDark: isDark);
                },
                borderRadius: BorderRadius.circular(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove_circle_outline, color: textColor),
                    const SizedBox(width: 8),
                    Text(
                      'Add Expense',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openIncomeExpenseBottomSheet({
    required bool isIncome,
    required bool isDark,
  }) {
    final Color backgroundColor =
        isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final typeList =
        isIncome ? controller.incomeTypes : controller.expenseTypes;

    Get.bottomSheet(
      Container(
        padding:
            const EdgeInsets.only(bottom: 40, top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              isIncome ? 'Add Income' : 'Add Expense',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 20),

            /// Amount Input
            TextField(
              controller: controller.amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  // Remove any non-digit/non-decimal characters
                  final text = newValue.text;
                  final cleaned = text.replaceAll(RegExp(r'[^0-9.]'), '');

                  // Prevent multiple decimal points
                  final parts = cleaned.split('.');
                  if (parts.length > 2) {
                    return oldValue;
                  }

                  return newValue.copyWith(
                    text: cleaned,
                    selection: TextSelection.collapsed(offset: cleaned.length),
                  );
                }),
              ],
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                hintText: 'Enter amount',
                hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                filled: true,
                fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// Expense Type (dropdown + typing)
            Stack(
              children: [
                TextField(
                  controller: controller.expenseTypeController,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    hintText: 'Enter or select type (e.g., Food)',
                    hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                    filled: true,
                    fillColor: isDark ? Colors.grey[850] : Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    suffixIcon: PopupMenuButton<String>(
                      icon: Icon(Icons.arrow_drop_down, color: textColor),
                      color: isDark ? Colors.grey[900] : Colors.white,
                      onSelected: (String value) {
                        controller.expenseTypeController.text = value;
                      },
                      itemBuilder: (BuildContext context) {
                        return typeList
                            .map((String choice) => PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                ))
                            .toList();
                      },
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),

            /// Slide to Confirm
            Builder(
              builder: (context) {
                return SlideAction(
                  text: 'Add transaction',
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  outerColor:
                      isIncome ? Colors.green.shade300 : Colors.red.shade300,
                  innerColor: Colors.white,
                  elevation: 4,
                  onSubmit: () {
                    final amount = controller.amountController.text.trim();
                    final type = controller.expenseTypeController.text.trim();

                    if (amount.isNotEmpty) {
                      Get.back();
                      Get.snackbar(
                        padding: EdgeInsets.all(30),
                        isIncome ? 'Income Added' : 'Expense Added',
                        isIncome
                            ? '₹$amount received from ${type.isEmpty ? "unspecified source" : type}'
                            : '₹$amount used for ${type.isEmpty ? "unspecified purpose" : type}',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    ).whenComplete(() {
      controller.amountController.clear();
      controller.expenseTypeController.clear();
    });
  }

  SizedBox _totalBalanceCard(Color textColor) {
    return SizedBox(
      height: Get.height * 0.15,
      width: Get.width,
      child: GlassContainer(
        child: Column(
          children: [
            Text(
              'Total Balance',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            Text(
              '₹ 1,500',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _themeModeSwitch() {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final isDark = themeController.isDark;

      return GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          themeController.toggleTheme(!isDark.value);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 60,
          height: 32,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isDark.value ? Colors.grey[850] : Colors.grey[300],
            borderRadius: BorderRadius.circular(32),
          ),
          child: Stack(
            children: [
              // Sliding + Rotating Icon
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment:
                    isDark.value ? Alignment.centerRight : Alignment.centerLeft,
                curve: Curves.easeInOut,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(
                    begin: 0,
                    end: isDark.value ? 1 : 0,
                  ),
                  builder: (context, value, child) {
                    return Transform.rotate(
                      angle: value * 3.14, // half rotation (180°)
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          isDark.value
                              ? Icons.nightlight_round
                              : Icons.wb_sunny,
                          size: 16,
                          color: isDark.value ? Colors.amber : Colors.orange,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
