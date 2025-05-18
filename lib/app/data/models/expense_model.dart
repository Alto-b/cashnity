import 'package:cashnity/app/domain/entities/expense_entity.dart';

class ExpenseModel extends ExpenseEntity {
  ExpenseModel({
    required super.userId,
    required super.isIncome,
    required super.amount,
    required super.description,
    required super.datetime,
  });

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'is_income': isIncome,
      'amount': amount,
      'description': description,
      'datetime': datetime.toIso8601String(),
    };
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      userId: map['user_id'],
      isIncome: map['is_income'],
      amount: map['amount'].toDouble(),
      description: map['description'],
      datetime: DateTime.parse(map['datetime']),
    );
  }
}
