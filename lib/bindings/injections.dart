// lib/bindings/injections.dart

import 'package:cashnity/app/core/services/storage_services.dart';
import 'package:cashnity/app/data/repositories/expense_repository_impl.dart';
import 'package:cashnity/app/data/repositories/login_repository_impl.dart';
import 'package:cashnity/app/data/repositories/user_repository_impl.dart';
import 'package:cashnity/app/domain/repositories/expense_repository.dart';
import 'package:cashnity/app/domain/repositories/login_repository.dart';
import 'package:cashnity/app/domain/repositories/user_repository.dart';
import 'package:cashnity/app/domain/use_cases/add_expense_use_case.dart';
import 'package:cashnity/app/domain/use_cases/get_expense_use_case.dart';
import 'package:cashnity/app/domain/use_cases/get_profile_use_case.dart';
import 'package:cashnity/app/domain/use_cases/login_use_case.dart';
import 'package:cashnity/app/domain/use_cases/sign_up_use_case.dart';
import 'package:cashnity/app/modules/home/controllers/home_controller.dart';
import 'package:cashnity/app/modules/login/controllers/login_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Injections extends Bindings {
  @override
  void dependencies() {
    // External Services
    Get.lazyPut<FirebaseFirestore>(() => FirebaseFirestore.instance,
        fenix: true);
// Services
    Get.lazyPut(() => StorageService(), fenix: true);

    // Repositories
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(), fenix: true);
    Get.lazyPut<LoginRepository>(() => LoginRepositoryImpl(Get.find()),
        fenix: true);
    Get.lazyPut<ExpenseRepository>(() => ExpenseRepositoryImpl(Get.find()),
        fenix: true);

    // Use Cases
    Get.lazyPut(() => SignUpUserUseCase(Get.find<UserRepository>()),
        fenix: true);
    Get.lazyPut(() => GetUserProfileUseCase(Get.find<UserRepository>()),
        fenix: true);
    Get.lazyPut(() => LoginUseCase(Get.find<LoginRepository>()), fenix: true);
    Get.lazyPut(() => AddExpenseUseCase(Get.find<ExpenseRepository>()),
        fenix: true);
    Get.lazyPut(() => GetExpensesUseCase(Get.find<ExpenseRepository>()),
        fenix: true);
    // Controllers
    Get.lazyPut(
        () => LoginController(
            signUpUserUseCase: Get.find(),
            getUserProfileUseCase: Get.find(),
            loginUseCase: Get.find()),
        fenix: true);
    Get.lazyPut(
        () => HomeController(
            addExpenseUseCase: Get.find(), getExpensesUseCase: Get.find()),
        fenix: true);
  }
}
