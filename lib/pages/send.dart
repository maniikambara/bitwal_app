import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/pages/receive.dart';
import 'package:bitwal_app/widgets/listtoken.dart';
import 'package:bitwal_app/widgets/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendTokenPage extends StatefulWidget {
  const SendTokenPage({super.key});

  @override
  State<SendTokenPage> createState() => _SendTokenPageState();
}

class _SendTokenPageState extends State<SendTokenPage> {
  String toAddress = '';
  double tokenAmount = 0;
  String memo = '';
  String selectedToken = "Select Token";
  double currentUserTokenBalance = 0;
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    _fetchCurrentUserTokenBalance();
  }

  Future<void> _fetchCurrentUserTokenBalance() async {
    try {
      currentUserId = getCurrentUserId(); // Get the current user's ID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      if (userDoc.exists) {
        setState(() {
          // Assuming token balance is stored directly in the user document
          currentUserTokenBalance = (userDoc.data() as Map<String, dynamic>)['tokenBalance'] ?? 0.0;
        });
      }
    } catch (e) {
      print('Error fetching token balance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          icon: Image.asset('lib/images/more.png', width: 40, height: 40),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset('lib/images/LogoText.png', width: 100, height: 40),
        actions: [
          IconButton(
            icon: Image.asset('lib/images/notif.png', width: 40, height: 40),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleButtons(),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListTokens()),
                );
                if (result != null) {
                  setState(() {
                    selectedToken = result;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF393E46),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedToken,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            _buildTextField('To', 'Enter User Document ID'),
            SizedBox(height: 8),
            Text(
              'Current Token Balance: $currentUserTokenBalance',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(height: 8),
            const Text(
              'Check User ID Before Transaction',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
            SizedBox(height: 20),
            _buildTextField('Amount', 'Enter Token Amount to Send', isNumeric: true),
            SizedBox(height: 20),
            _buildTextField(
              'Memo',
              'Ensure the memo is filled in correctly for a successful fund transfer',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (toAddress.isEmpty || tokenAmount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields correctly')),
                  );
                  return;
                }

                if (tokenAmount > currentUserTokenBalance) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Insufficient token balance')),
                  );
                  return;
                }

                try {
                  final recipientDoc = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(toAddress)
                      .get();

                  if (!recipientDoc.exists) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Recipient not found')),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderPage(
                        type: 'send',
                        token: selectedToken,
                        amount: tokenAmount,
                        recipientId: toAddress,
                        memo: memo,
                        timestamp: DateTime.now(),
                        currency: 'IDR',
                        price: 0.0,
                      ),
                    ),
                  ).then((_) async {
                    await _updateTokenBalances();
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800],
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text(
                'CONFIRM',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateTokenBalances() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.runTransaction((transaction) async {
        DocumentReference senderRef = firestore.collection('users').doc(currentUserId);
        DocumentReference recipientRef = firestore.collection('users').doc(toAddress);

        DocumentSnapshot senderSnapshot = await transaction.get(senderRef);
        DocumentSnapshot recipientSnapshot = await transaction.get(recipientRef);

        // Assuming tokenBalance is a top-level field; adjust if it's nested in a subcollection
        double senderNewBalance = (senderSnapshot.data() as Map<String, dynamic>)['tokenBalance'] - tokenAmount;
        double recipientNewBalance = (recipientSnapshot.data() as Map<String, dynamic>)['tokenBalance'] + tokenAmount;

        transaction.update(senderRef, {'tokenBalance': senderNewBalance});
        transaction.update(recipientRef, {'tokenBalance': recipientNewBalance});
      });

      await _fetchCurrentUserTokenBalance();
    } catch (e) {
      print('Error updating token balances: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to complete transaction: ${e.toString()}')),
      );
    }
  }

  Widget _buildTextField(String label, String hint, {bool isNumeric = false}) {
    return TextField(
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      onChanged: (value) {
        setState(() {
          if (label == 'To') {
            toAddress = value;
          } else if (label == 'Amount') {
            tokenAmount = (double.tryParse(value) ?? 0.0);
          } else if (label == 'Memo') {
            memo = value;
          }
        });
      },
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Colors.white70),
        hintStyle: const TextStyle(color: Colors.white30),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white30),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF222831),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            _buildTab("Crypto Send", left: true),
            _buildTab("Receive", right: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, {bool left = false, bool right = true}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (text == "Receive") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ReceiveTokenPage()));
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: text == "Receive" ? Color(0xFF222831) : Color(0xFF393E46),
              borderRadius: BorderRadius.horizontal(
                left: left ? Radius.circular(40) : Radius.zero,
                right: right ? Radius.circular(40) : Radius.zero,
              ),
            ),
            child: Text(text, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  String getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw 'No authenticated user found';
    }
    return user.uid;
  }
}
