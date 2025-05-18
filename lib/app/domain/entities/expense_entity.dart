class ExpenseEntity {
  final String userId;
  final bool isIncome;
  final double amount;
  final String description;
  final DateTime datetime;

  ExpenseEntity({
    required this.userId,
    required this.isIncome,
    required this.amount,
    required this.description,
    required this.datetime,
  });
}
