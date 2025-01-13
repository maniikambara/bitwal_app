import 'package:bitwal_app/widgets/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitwal_app/services/auth_service.dart';
import 'package:bitwal_app/models/token.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bitwal_app/models/user.dart';

class BuyToken extends StatefulWidget {
  const BuyToken({super.key, required this.tokenAbbr});
  final String tokenAbbr;

  @override
  State<BuyToken> createState() => _BuyTokenState();
}

class _BuyTokenState extends State<BuyToken> {
  String selectedCurrency = 'IDR';
  int amount = 0;
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    selectedCurrency = 'IDR';
  }

  Future<void> _purchaseToken(Token token) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to purchase tokens')),
        );
        return;
      }

      final totalCost = amount.toDouble();
      final tokenAmount = (amount / token.price).floor();

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final userDoc = await transaction.get(userRef);

        final currentBalance = (userDoc.data()?['balance'] ?? 0.0) as double;
        final currentTokens = (userDoc.data()?['tokens'] ?? {}) as Map<String, dynamic>;

        if (currentBalance < totalCost) {
          throw 'Insufficient balance';
        }

        Map<String, dynamic> updatedTokens = Map.from(currentTokens);
        updatedTokens[token.abbreviation] = 
          (updatedTokens[token.abbreviation] ?? 0) + tokenAmount;

        final newBalance = currentBalance - totalCost;

        transaction.update(userRef, {
          'tokens': updatedTokens,
          'balance': newBalance,
        });

        final transactionRef = FirebaseFirestore.instance.collection('transactions').doc();
        transaction.set(transactionRef, {
          'userId': user.uid,
          'type': 'token_purchase',
          'token': token.abbreviation,
          'amount': tokenAmount,
          'totalCost': totalCost,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchased $tokenAmount ${token.abbreviation}')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPage(
            type: 'Buy',
            token: token.abbreviation,
            amount: tokenAmount.toDouble(),
            currency: selectedCurrency,
            price: token.price,
            recipientId: '',
            memo: '',
            timestamp: DateTime.now(),
          ),
        ),
      );
    } catch (e) {
      print('Token purchase error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase failed: $e')),
      );
    }
  }

  void _updateAmount(String text) {
    setState(() {
      if (text == 'C') {
        amount = 0;
      } else if (amount.toString().length < 10) {
        amount = int.parse(amount == 0 ? text : '$amount$text');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<dynamic>?>(
      stream: context.read<AuthService>().availableTokens,
      builder: (context, tokenSnapshot) {
        return StreamBuilder<UserModel?>(
          stream: context.read<AuthService>().user,
          builder: (context, userSnapshot) {
            if (tokenSnapshot.connectionState == ConnectionState.waiting ||
                userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (tokenSnapshot.hasError) {
              return Center(child: Text('Token Error: ${tokenSnapshot.error}'));
            }

            if (userSnapshot.hasError) {
              return Center(child: Text('User Error: ${userSnapshot.error}'));
            }

            final tokens = tokenSnapshot.data ?? [];
            final token = tokens.firstWhere(
              (t) => t.abbreviation == widget.tokenAbbr,
              orElse: () => Token(
                name: '',
                abbreviation: widget.tokenAbbr,
                price: 0,
                icon: '',
                amount: 0,
              ),
            );

            final currencyItems = {'IDR', widget.tokenAbbr}.toList();

            if (!currencyItems.contains(selectedCurrency)) {
              selectedCurrency = 'IDR';
            }

            return Scaffold(
              backgroundColor: const Color(0xFF222831),
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                backgroundColor: const Color(0xFF222831),
                elevation: 0,
                toolbarHeight: 100,
                title: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'BUY ${token.abbreviation}',
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DropdownButton<String>(
                        value: selectedCurrency,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCurrency = newValue!;
                          });
                        },
                        dropdownColor: const Color(0xFF393E46),
                        items: currencyItems.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                if (value == selectedCurrency)
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFD65A31),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                const SizedBox(width: 8),
                                Text(value, style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          selectedCurrency,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          amount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      selectedCurrency == widget.tokenAbbr
                          ? '≈ ${currencyFormat.format(amount * token.price)}'
                          : '≈ ${(amount / token.price).floor()} ${token.abbreviation}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        if (index == 9) {
                          return const SizedBox.shrink();
                        }
                        if (index == 10) {
                          return _buildNumKey('0');
                        }
                        if (index == 11) {
                          return _buildNumKey('C', isSpecial: true);
                        }
                        return _buildNumKey((index + 1).toString());
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: amount > 0 
                        ? () => _purchaseToken(token)
                        : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD65A31),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'BUY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildNumKey(String text, {bool isSpecial = false}) {
    return InkWell(
      onTap: () => _updateAmount(text),
      child: Container(
        decoration: BoxDecoration(
          color: isSpecial ? Colors.red[100] : const Color(0xFF393E46),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSpecial ? Colors.red : Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
