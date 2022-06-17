class Card {
  int id;
  int cardTypeId;
  String name;
  String cardNumber;
  num? authorizedAmount;
  DateTime authExpDate;
  int cardSecurityCode;
  // CardType cardType;

  Card(
      {required this.id,
      this.cardTypeId = 1,
      required this.name,
      required this.cardNumber,
      required this.authExpDate,
      this.authorizedAmount,
      required this.cardSecurityCode});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
        id: json['id'],
        cardTypeId: json['card_type_id'],
        name: json['name'],
        cardNumber: json['card_number'],
        authExpDate: DateTime.parse(json['auth_exp_date']),
        authorizedAmount: json['authorized_amount'],
        cardSecurityCode: json['card_security_code']);
  }
}
