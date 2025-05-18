import 'package:cashnity/app/domain/entities/expense_entity.dart';

abstract class ExpenseRepository {
  Future<String> addExpense(ExpenseEntity expense);
  Future<List<ExpenseEntity>> getExpenses(String userId);
}
