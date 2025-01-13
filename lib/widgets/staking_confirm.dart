import 'package:bitwal_app/widgets/payment.dart';
import 'package:flutter/material.dart';

class StackingConfirmPage extends StatelessWidget {
  const StackingConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222831),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'STAKING',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stake ● TRIZZ COIN',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.white24, height: 30),
            const SizedBox(height: 10),
            const Text(
              'Your order has been created',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildInfoText('Interest distribution:', 'Daily'),
            _buildInfoText('APR:', '4.00% - 14.00%'),
            _buildInfoText('Estimated daily profit:', '0.00000000 TRIZZ'),
            const SizedBox(height: 30),
            const Text(
              'Order Details',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            _buildInfoText('Staking time:', '2024-10-10 17:27:35'),
            _buildInfoText('Interest accrual start time:', '2024-10-10 17:27:35'),
            _buildInfoText('Interest distribution time:', '2024-10-10 17:27:35'),
            _buildInfoText('Redemption request time:', 'D day'),
            _buildInfoText('Redemption crediting time:', 'D+4 day'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentPage()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5C00),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.white70, fontSize: 16),
          children: [
            TextSpan(text: '$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
