import 'package:cloud_firestore/cloud_firestore.dart';

class FinanceTransactionModel {
  String title;
  double money;
  Timestamp createdAt;
  Timestamp transactedAt;
  String type;
  double balance;
  double balanceFinal;
  String transactedBy;

  FinanceTransactionModel({
    required this.title,
    required this.money,
    required this.createdAt,
    required this.transactedAt,
    required this.type,
    required this.balance,
    required this.balanceFinal,
    required this.transactedBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'money': money,
      'createdAt': createdAt,
      'transactedAt': transactedAt,
      'type': type,
      'balance': balance,
      'balanceFinal': balanceFinal,
      'transactedBy': transactedBy,
    };
  }

  FinanceTransactionModel.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          money: json['money']! as double,
          createdAt: json['createdAt']! as Timestamp,
          transactedAt: json['transactedAt']! as Timestamp,
          type: json['type']! as String,
          balance: json['balance']! as double,
          balanceFinal: json['balanceFinal']! as double,
          transactedBy: json['transactedBy']! as String,
        );
}
