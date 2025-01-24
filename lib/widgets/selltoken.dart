import 'package:bitwal_app/widgets/order.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bitwal_app/models/token.dart';
import 'package:intl/intl.dart';

class SellToken extends StatefulWidget {
  const SellToken({super.key, required this.name, required String tokenAbbr});
  final String name;

  @override
  State<SellToken> createState() => _SellTokenState();
}

class _SellTokenState extends State<SellToken> {
  String selectedCurrency = ''; 
  int amount = 0;
  Token? selectedToken;
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    selectedCurrency = widget.name;
    _loadToken();
  }

  Future<void> _loadToken() async {
    try {
      final tokenDoc = await FirebaseFirestore.instance
          .collection('tokens')
          .doc(widget.name)
          .get();

      if (tokenDoc.exists) {
        setState(() {
          selectedToken = Token.fromMap(tokenDoc.data() as Map<String, dynamic>);
        });
      }
    } catch (e) {
      print("Error fetching token details: $e");
    }
  }

  Future<void> _sellToken() async {
    if (selectedToken == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid sell details')),
      );
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please log in to sell tokens')),
        );
        return;
      }

      final totalCost = amount * selectedToken!.price;
      final tokenAmount = (amount / selectedToken!.price).floor();

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        final userDoc = await transaction.get(userRef);

        final currentBalance = (userDoc.data()?['balance'] ?? 0.0) as double;
        final currentTokens = (userDoc.data()?['tokens'] ?? {}) as Map<String, dynamic>;

        if ((currentTokens[selectedToken!.abbreviation] ?? 0) < tokenAmount) {
          throw 'Insufficient tokens to sell';
        }

        Map<String, dynamic> updatedTokens = Map.from(currentTokens);
        updatedTokens[selectedToken!.abbreviation] =
            (updatedTokens[selectedToken!.abbreviation] ?? 0) - tokenAmount;

        final newBalance = currentBalance + totalCost;

        transaction.update(userRef, {
          'tokens': updatedTokens,
          'balance': newBalance,
        });

        final transactionRef = FirebaseFirestore.instance.collection('transactions').doc();
        transaction.set(transactionRef, {
          'userId': user.uid,
          'type': 'token_sale',
          'token': selectedToken!.abbreviation,
          'amount': tokenAmount,
          'totalCost': totalCost,
          'timestamp': FieldValue.serverTimestamp(),
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sold $tokenAmount ${selectedToken!.abbreviation}')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderPage(
            type: 'Sell',
            token: selectedToken!.abbreviation,
            amount: tokenAmount.toDouble(),
            currency: selectedCurrency,
            price: selectedToken!.price,
            recipientId: '',
            memo: '',
            timestamp: DateTime.now(),
          ),
        ),
      );
    } catch (e) {
      print('Token sale error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sale failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              'SELL ${widget.name}',
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
                items: <String>['IDR', widget.name].map<DropdownMenuItem<String>>((String value) {
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
              selectedToken != null
                  ? (selectedCurrency == widget.name
                      ? '${(amount * selectedToken!.price).toStringAsFixed(0)} IDR'
                      : '${(amount / selectedToken!.price).toStringAsFixed(8)} ${selectedToken!.abbreviation}')
                  : 'Loading...',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildAmountButton(100),
                buildAmountButton(500),
                buildAmountButton(1000),
                buildAmountButton(5000),
                buildAmountButton(10000),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return buildKeyPadButton('00');
                  } else if (index == 10) {
                    return buildKeyPadButton('0');
                  } else if (index == 11) {
                    return buildKeyPadButton('<');
                  } else {
                    return buildKeyPadButton((index + 1).toString());
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: _sellToken,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD65A31),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'REVIEW ORDER',
                style: TextStyle(
                  color: Color(0xFF222831),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAmountButton(int value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          amount += value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF393E46),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKeyPadButton(String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (value == '<') {
            if (amount > 0) {
              amount = amount ~/ 10;
            }
          } else {
            if (amount.toString().length < 18) {
              amount = int.parse(amount.toString() + value);
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF393E46),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
