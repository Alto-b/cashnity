import 'package:cashnity/app/domain/entities/expense_entity.dart';
import 'package:cashnity/app/domain/repositories/expense_repository.dart';

class GetExpensesUseCase {
  final ExpenseRepository repository;

  GetExpensesUseCase(this.repository);

  Future<List<ExpenseEntity>> call(String userId) {
    return repository.getExpenses(userId);
  }
}
