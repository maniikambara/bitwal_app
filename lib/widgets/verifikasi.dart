import 'package:bitwal_app/widgets/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VerifikasiPage extends StatelessWidget {
  final String type;
  final String token;
  final double amount;
  final String recipientId;
  final String memo;
  final DateTime timestamp;

  const VerifikasiPage({
    super.key,
    required this.type,
    required this.token,
    required this.amount,
    required this.recipientId,
    required this.memo,
    required this.timestamp,
  });

  Widget _buildTransactionDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[400])),
          Text(value, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format the current date and time
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);

    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222831),
        title: const Text(
          'Verification',
          style: TextStyle(color: Colors.white), // Make title text white
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTransactionDetail('Amount', '$amount $token'),
            _buildTransactionDetail('To', recipientId),
            _buildTransactionDetail('Date', formattedDate),
            
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await _processTransaction(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800],
                minimumSize: const Size(double.infinity, 60),
              ),
              child: const Text(
                'CONFIRM TRANSACTION',
                style: TextStyle(
                  color: Colors.white, // Make button text white
                  fontSize: 18, // Increase font size
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _processTransaction(BuildContext context) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw 'User not authenticated';
      }

      // If recipient ID is empty, set it to the current user's ID
      final processedRecipientId = recipientId.trim().isEmpty ? 'Myself' : recipientId;

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Validate document references
        final senderRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
        final recipientRef = FirebaseFirestore.instance.collection('users').doc(processedRecipientId);

        // Fetch documents with explicit null check
        final senderDoc = await transaction.get(senderRef);
        final recipientDoc = await transaction.get(recipientRef);

        if (!senderDoc.exists) {
          throw 'Sender account not found';
        }

        // If recipient is 'Myself', use the same document
        if (processedRecipientId == 'Myself' && senderDoc.id != currentUser.uid) {
          throw 'Invalid self-transaction';
        }

        // Safely extract token balances with default values
        final senderData = senderDoc.data() ?? {};
        final recipientData = processedRecipientId == 'Myself' ? senderData : (recipientDoc.data() ?? {});

        // Ensure 'tokens' field is a map and safely extract token balances
        final senderTokens = (senderData['tokens']?[token] ?? 0.0) as double;
        final recipientTokens = (recipientData['tokens']?[token] ?? 0.0) as double;

        // Validate sender has enough tokens
        if (senderTokens < amount) {
          throw 'Insufficient $token tokens';
        }

        // Prepare token balance updates
        final senderTokenUpdate = {
          'tokens.$token': senderTokens - amount
        };
        final recipientTokenUpdate = {
          'tokens.$token': recipientTokens + amount
        };

        // Perform atomic updates
        transaction.update(senderRef, senderTokenUpdate);
        
        // Only update recipient if not a self-transaction
        if (processedRecipientId != 'Myself') {
          transaction.update(recipientRef, recipientTokenUpdate);
        }

        // Log transaction details
        await FirebaseFirestore.instance.collection('transactions').add({
          'senderId': currentUser.uid,
          'recipientId': processedRecipientId,
          'tokenType': token,
          'amount': amount,
          'timestamp': FieldValue.serverTimestamp(),
          'type': processedRecipientId == 'Myself' ? 'self_transfer' : 'transfer',
        });
      });

      // Navigate to payment success page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PaymentPage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaction Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
      print('Transaction Error: $e'); // Add logging for debugging
    }
  }
}
