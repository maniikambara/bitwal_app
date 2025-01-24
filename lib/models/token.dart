class Token {
  final String name;
  final String abbreviation;
  final double price;
  final String icon;
  final double amount;

  Token({
    required this.name,
    required this.abbreviation,
    required this.price,
    required this.icon,
    required this.amount,
  });

  // Convert Token object to Map for saving to Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'abbreviation': abbreviation,
      'price': price,
      'icon': icon,
      'amount': amount,
    };
  }

  // Convert Map to Token object
  factory Token.fromMap(Map<String, dynamic> map) {
    return Token(
      name: map['name'] ?? '',
      abbreviation: map['abbreviation'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      icon: map['icon'] ?? '',
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Getter to return abbreviation as the symbol of the token
  String get symbol => abbreviation;
}