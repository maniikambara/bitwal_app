import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:bitwal_app/models/user.dart';
import 'package:bitwal_app/models/token.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const double INITIAL_BALANCE = 100000000;
  static const double INITIAL_BTC_AMOUNT = 100;

  User? get currentUser => _auth.currentUser;

  Stream<UserModel?> get user {
    return _auth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        final data = doc.data() ?? {};

        // Ensure tokens is a list
        List<Token> tokens = [];
        if (data.containsKey('tokens') && data['tokens'] is List) {
          tokens = (data['tokens'] as List).map((tokenData) {
            return Token(
              name: tokenData['name'] ?? '',
              abbreviation: tokenData['abbreviation'] ?? '',
              price: (tokenData['price'] as num?)?.toDouble() ?? 0.0,
              icon: tokenData['icon'] ?? '',
              amount: (tokenData['amount'] as num?)?.toDouble() ?? 0.0,
            );
          }).toList();
        }

        return UserModel(
          uid: user.uid,
          username: data['username'] ?? '',
          balance: (data['balance'] as num?)?.toDouble() ?? 0.0,
          tokens: tokens,
        );
      } catch (e) {
        print('Error fetching user data: $e');
        return null;
      }
    });
  }

  Stream<List<Token>> get availableTokens {
    return _firestore.collection('tokens').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Token(
          name: data['name'] as String,
          abbreviation: data['abbreviation'] as String,
          price: (data['price'] as num).toDouble(),
          icon: data['icon'] as String,
          amount: 0.0, // Default amount for available tokens
        );
      }).toList();
    });
  }

  Future<UserCredential?> signUp(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final btcDoc = await _firestore.collection('tokens').doc('BTC').get();
      if (!btcDoc.exists) {
        throw Exception('BTC token not found in database');
      }

      final btcData = btcDoc.data()!;

      final btcToken = Token(
        name: btcData['name'] as String,
        abbreviation: btcData['abbreviation'] as String,
        price: (btcData['price'] as num).toDouble(),
        icon: btcData['icon'] as String,
        amount: INITIAL_BTC_AMOUNT,
      );

      final userData = UserModel(
        uid: userCredential.user!.uid,
        username: username,
        balance: INITIAL_BALANCE,
        tokens: [btcToken],
      );

      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userData.toMap()); // Save user data with tokens

      return userCredential;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<UserModel?> getUserData() async {
    if (currentUser != null) {
      try {
        DocumentSnapshot doc = await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .get();
        final data = doc.data() as Map<String, dynamic>;

        // Ensure tokens is a list
        List<Token> tokens = [];
        if (data.containsKey('tokens') && data['tokens'] is List) {
          tokens = (data['tokens'] as List).map((tokenData) {
            return Token(
              name: tokenData['name'] ?? '',
              abbreviation: tokenData['abbreviation'] ?? '',
              price: (tokenData['price'] as num?)?.toDouble() ?? 0.0,
              icon: tokenData['icon'] ?? '',
              amount: (tokenData['amount'] as num?)?.toDouble() ?? 0.0,
            );
          }).toList();
        }

        return UserModel(
          uid: currentUser!.uid,
          username: data['username'] ?? '',
          balance: (data['balance'] as num?)?.toDouble() ?? 0.0,
          tokens: tokens,
        );
      } catch (e) {
        print('Error fetching user data: $e');
        return null;
      }
    }
    return null;
  }

  Future<void> updateBalance(double newBalance) async {
    if (currentUser != null) {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .update({'balance': newBalance});
      notifyListeners();
    }
  }

  Future<void> addToken(Token token) async {
    if (currentUser != null) {
      final userData = await getUserData();
      if (userData != null) {
        final existingTokens = List<Token>.from(userData.tokens);
        existingTokens.add(token);

        await _firestore
            .collection('users')
            .doc(currentUser!.uid)
            .update({
          'tokens': existingTokens.map((t) => t.toMap()).toList(),
        });
        notifyListeners();
      }
    }
  }

  Future<void> updateTokenAmount(String symbol, double newAmount) async {
    if (currentUser != null) {
      final userData = await getUserData();
      if (userData != null) {
        final tokens = userData.tokens;
        final tokenIndex = tokens.indexWhere((t) => t.abbreviation == symbol);

        if (tokenIndex != -1) {
          tokens[tokenIndex] = Token(
            name: tokens[tokenIndex].name,
            abbreviation: tokens[tokenIndex].abbreviation,
            price: tokens[tokenIndex].price,
            icon: tokens[tokenIndex].icon,
            amount: newAmount,
          );

          await _firestore
              .collection('users')
              .doc(currentUser!.uid)
              .update({
            'tokens': tokens.map((t) => t.toMap()).toList(),
          });
          notifyListeners();
        }
      }
    }
  }

  Future<void> updateUsername(String newUsername) async {
    if (currentUser != null) {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .update({'username': newUsername});
      notifyListeners();
    }
  }

  Future<void> deleteUser() async {
    if (currentUser != null) {
      await _firestore.collection('users').doc(currentUser!.uid).delete();
      await currentUser!.delete();
      await signOut();
    }
  }
}
