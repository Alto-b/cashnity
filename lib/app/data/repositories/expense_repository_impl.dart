import 'package:cashnity/app/data/models/expense_model.dart';
import 'package:cashnity/app/domain/entities/expense_entity.dart';
import 'package:cashnity/app/domain/repositories/expense_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final FirebaseFirestore _firestore;

  ExpenseRepositoryImpl(this._firestore);

  @override
  Future<String> addExpense(ExpenseEntity expense) async {
    try {
      final model = ExpenseModel(
        userId: expense.userId,
        isIncome: expense.isIncome,
        amount: expense.amount,
        description: expense.description,
        datetime: expense.datetime,
      );

      await _firestore.collection('expense_db').add(model.toMap());
      return "Success";
    } catch (e) {
      return "Failed: $e";
    }
  }

  @override
  Future<List<ExpenseEntity>> getExpenses(String userId) async {
    final snapshot = await _firestore
        .collection('expense_db')
        .where('user_id', isEqualTo: userId)
        .orderBy('datetime', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => ExpenseModel.fromMap(doc.data()))
        .toList();
  }
}
