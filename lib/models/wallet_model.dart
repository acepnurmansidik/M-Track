class WalletModel {
  final String id;
  final String vaNumber;
  final String walletName;
  final double amount;

  WalletModel({
    required this.id,
    required this.vaNumber,
    required this.amount,
    required this.walletName,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['_id'],
      vaNumber: json['va_number'],
      walletName: json['wallet_name'],
      amount: json['amount'],
    );
  }
}
