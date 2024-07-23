class Payment {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool status;
  final String bankName;
  final String accountNumber;
  final String currency;
  final int user;

  Payment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.bankName,
    required this.accountNumber,
    required this.currency,
    required this.user,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'],
      bankName: json['bank_name'],
      accountNumber: json['account_number'],
      currency: json['currency'],
      user: json['user'],
    );
  }
}
