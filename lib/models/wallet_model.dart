class WalletModelProps {
  bool success;
  String message;
  List<WalletDaum> data;

  WalletModelProps({
    required this.success,
    required this.message,
    required this.data,
  });

  factory WalletModelProps.fromJson(Map<String, dynamic> json) {
    return WalletModelProps(
      success: json["success"],
      message: json["message"],
      data: (json["data"] as List<dynamic>)
          .map((item) => WalletDaum.fromJson(item))
          .toList(),
    );
  }
}

class WalletDaum {
  final String id;
  final String vaNumber;
  final String walletName;
  final String ownerName;
  final CurrencyId currencyId;
  final int amount;

  WalletDaum({
    required this.id,
    required this.vaNumber,
    required this.amount,
    required this.walletName,
    required this.ownerName,
    required this.currencyId,
  });

  factory WalletDaum.fromJson(Map<String, dynamic> json) {
    return WalletDaum(
      id: json['_id'],
      vaNumber: json['va_number'],
      walletName: json['wallet_name'],
      amount: json['amount'],
      ownerName: json['owner_name'],
      currencyId: CurrencyId.fromJson(json['currency_id']),
    );
  }
}

class CurrencyId {
  String? id;
  String? value;
  String? description;

  CurrencyId({this.id, this.value, this.description});

  factory CurrencyId.fromJson(Map<String, dynamic> json) {
    return CurrencyId(
      id: json['_id'],
      value: json['value'],
      description: json['description'],
    );
  }
}
