import 'package:flutter/material.dart';
import 'package:bitwal_app/pages/more.dart';
import 'package:bitwal_app/pages/notif.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({super.key});

  @override
  _ConvertPageState createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  String selectedCurrency = 'ETH';
  String selectedBalanceCurrency = 'IDR';
  double tokenAmount = 1.0;
  double tokenPrice = 2500.10; // Example price
  double userBalance = 0.0;
  Map<String, dynamic> userTokens = {}; // To track user's tokens

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'No authenticated user';
      }

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        userBalance = (userDoc.data()?['balance'] ?? 0.0) as double;
        userTokens = (userDoc.data()?['tokens'] ?? {}) as Map<String, dynamic>;
      });
    } catch (e) {
      print('Error fetching user data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _purchaseToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw 'No authenticated user';
      }

      // Calculate total cost
      final totalCost = tokenAmount * tokenPrice;

      // Check if user has enough balance
      if (userBalance < totalCost) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Insufficient balance')),
        );
        return;
      }

      // Firestore transaction to update user's tokens and balance
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

        // Update user tokens
        Map<String, dynamic> updatedTokens = Map.from(userTokens);
        updatedTokens[selectedCurrency] = 
          (updatedTokens[selectedCurrency] ?? 0.0) + tokenAmount;

        // Reduce user balance
        final newBalance = userBalance - totalCost;

        // Update user document
        transaction.update(userRef, {
          'tokens': updatedTokens,
          'balance': newBalance,
        });
      });

      // Refresh user data
      await _fetchUserData();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchased $tokenAmount $selectedCurrency')),
      );
    } catch (e) {
      print('Token purchase error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Purchase failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildToggleButtons(context),
              const SizedBox(height: 20),
              const Text(
                "Crypto to Currency",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Satoshi'),
              ),
              const SizedBox(height: 10),
              _buildConversionInterface(context),
              const SizedBox(height: 20),
              Text(
                "Your Balance: Rp. ${userBalance.toStringAsFixed(2)}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const Spacer(),
              _buildConvertButton(context),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConversionInterface(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildCurrencyContainer("Amount", selectedCurrency, "Rp. ${(tokenAmount * tokenPrice).toStringAsFixed(2)}"),
            const SizedBox(height: 10),
            _buildCurrencyContainer("Balance", selectedBalanceCurrency, "Rp. ${userBalance.toStringAsFixed(2)} (+0.056%)"),
          ],
        ),
        Positioned(
          top: 96,
          left: MediaQuery.of(context).size.width / 2 - 33,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF393E46), width: 4.0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const RotatedBox(
              quarterTurns: 1,
              child: Image(
                image: AssetImage('lib/images/swap.png'),
                fit: BoxFit.cover,
                width: 38,
                height: 38,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyContainer(String amount, String currency, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF222831),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: amount == "Amount" ? "Enter $currency Amount" : amount,
                    hintStyle: const TextStyle(color: Colors.white54),
                  ),
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                  onChanged: (value) {
                    if (amount == "Amount") {
                      setState(() {
                        tokenAmount = double.tryParse(value) ?? 1.0;
                      });
                    }
                  },
                ),
              ),
              DropdownButton<String>(
                value: amount == "Amount" ? selectedCurrency : selectedBalanceCurrency,
                items: amount == "Amount" 
                  ? ['ETH', 'USDT', 'BTC'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList()
                  : ['IDR'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: const TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (amount == "Amount") {
                      selectedCurrency = newValue!;
                    } else {
                      selectedBalanceCurrency = newValue!;
                    }
                  });
                },
                dropdownColor: const Color(0xFF222831),
                iconEnabledColor: Colors.white,
                underline: const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildConvertButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _purchaseToken,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD65A31),
            padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "CONVERT",
          style: TextStyle(
            color: Color(0xFF393E46),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF393E46),
      elevation: 0,
      toolbarHeight: 100,
      leading: IconButton(
        icon: Image.asset('lib/images/more.png', width: 40, height: 40),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const More()),
        ),
      ),
      centerTitle: true,
      title: Image.asset('lib/images/LogoText.png', width: 100, height: 40),
      actions: [
        IconButton(
          icon: Image.asset('lib/images/notif.png', width: 40, height: 40),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF222831),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              _buildTab("Crypto Swap", context, left: true),
              _buildTab("Crypto to Currency", context, right: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, BuildContext context, {bool left = true, bool right = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (text == "Crypto Swap") {
              Navigator.pop(context);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: text == "Crypto to Currency" ? const Color(0xFF393E46) : const Color(0xFF222831),
              borderRadius: BorderRadius.horizontal(
                left: left ? const Radius.circular(40) : Radius.zero,
                right: right ? const Radius.circular(40) : Radius.zero,
              ),
            ),
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
