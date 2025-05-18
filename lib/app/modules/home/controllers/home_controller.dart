import 'package:cashnity/app/core/services/storage_services.dart';
import 'package:cashnity/app/domain/entities/expense_entity.dart';
import 'package:cashnity/app/domain/use_cases/add_expense_use_case.dart';
import 'package:cashnity/app/domain/use_cases/get_expense_use_case.dart';
import 'package:cashnity/app/routes/app_pages.dart';
import 'package:cashnity/app/services/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController({
    required this.addExpenseUseCase,
    required this.getExpensesUseCase,
  });

  final AddExpenseUseCase addExpenseUseCase;
  final GetExpensesUseCase getExpensesUseCase;

  final storageService = Get.find<StorageService>();

  final themeController = Get.find<ThemeController>();

  //text editing conntrollers
  final TextEditingController amountController = TextEditingController();
  final TextEditingController expenseTypeController = TextEditingController();

  // list for income options
  final List<String> incomeTypes = [
    '💼 Salary',
    '📈 Investments',
    '🎁 Gifts',
    '🛒 Freelance',
    '🏦 Interest',
    '💸 Bonus',
    '📤 Refund',
  ];

  //list for expense  options
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

  //for fetching expense list
  RxList<ExpenseEntity> expenses = <ExpenseEntity>[].obs;

  //to add an expense/income
  Future<void> addExpense(ExpenseEntity expense) async {
    final result = await addExpenseUseCase(expense);
    debugPrint("[addExpense] $result");
    await fetchExpenses(expense.userId);
  }

  //to fetch expense/income history
  Future<void> fetchExpenses(String userId) async {
    final data = await getExpensesUseCase(userId);
    expenses.value = data;
  }

  void showLogoutDialog() {
    Get.defaultDialog(
      title: '',
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: Column(
        children: [
          Icon(Icons.logout, color: Colors.redAccent, size: 50),
          const SizedBox(height: 15),
          Text(
            "Are you sure you want to logout?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.back(); // Cancel
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Cancel"),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  handleLogout();
                  Get.offAllNamed(Routes.SPLASH); // Logout action
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text("Yes"),
                ),
              ),
            ],
          )
        ],
      ),
      radius: 12,
      barrierDismissible: false,
    );
  }

  void handleLogout() {
    storageService.setLoginStatus(false);
  }
}
