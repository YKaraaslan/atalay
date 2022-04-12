class ApplicationFinancesModel {
  double balance;

  ApplicationFinancesModel({
    required this.balance,
  });

  ApplicationFinancesModel.fromJson(Map<String, Object?> json)
      : this(
          balance: json['balance']! as double,
        );
}
