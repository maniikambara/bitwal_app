import 'package:bitwal_app/models/token.dart';

class UserModel {
  final String uid;
  final String username;
  final double balance;
  final List<Token> tokens;

  UserModel({
    required this.uid,
    required this.username,
    required this.balance,
    required this.tokens,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'balance': balance,
      'tokens': tokens.map((token) => token.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      username: map['username'] ?? '',
      balance: (map['balance'] ?? 0.0).toDouble(),
      tokens: (map['tokens'] as List<dynamic>?)
              ?.map((token) => Token.fromMap(token as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
