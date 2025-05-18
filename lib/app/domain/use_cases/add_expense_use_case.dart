import 'package:cashnity/app/domain/entities/expense_entity.dart';
import 'package:cashnity/app/domain/repositories/expense_repository.dart';

class AddExpenseUseCase {
  final ExpenseRepository repository;

  AddExpenseUseCase(this.repository);

  Future<String> call(ExpenseEntity expense) {
    return repository.addExpense(expense);
  }
}
