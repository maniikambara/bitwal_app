import 'package:bitwal_app/widgets/verifikasi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatelessWidget {
  final String type;
  final String token;
  final double amount;
  final String recipientId;
  final String memo;
  final DateTime timestamp;
  final String currency;
  final double price;

  const OrderPage({
    super.key, 
    required this.type,
    required this.token,
    required this.amount,
    required this.recipientId,
    required this.memo,
    required this.timestamp,
    required this.currency,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    // Format the current date and time
    final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);

    return Scaffold(
      backgroundColor: Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: Color(0xFF222831),
        automaticallyImplyLeading: false,
        title: const Text(
          'Shipping Details',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Shipping Information'),
            _buildInfoRow('Shipping Date', formattedDate),
            _buildInfoRow('Type', type),
            _buildInfoRow('Token', token),
            _buildInfoRow('Amount', amount.toString()),
            _buildInfoRow('Recipient ID', recipientId),
            _buildInfoRow('Memo', memo),
            
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD65A31),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerifikasiPage(
                        type: type,
                        token: token,
                        amount: amount,
                        recipientId: recipientId,
                        memo: memo,
                        timestamp: timestamp,
                      ),
                    ),
                  );
                },
                child: const Text('Proceed to Verification', style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel order',
                  style: TextStyle(color: Colors.orange[800], fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
