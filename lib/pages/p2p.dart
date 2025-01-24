import 'package:bitwal_app/pages/more.dart';
import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/widgets/p2pdetail.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class P2PTradingPage extends StatefulWidget {
  const P2PTradingPage({super.key});

  @override
  _P2PTradingPageState createState() => _P2PTradingPageState();
}

class _P2PTradingPageState extends State<P2PTradingPage> {
  bool isBuySelected = true;

  // Generate random amount and limit for transactions
  String getRandomAmount() {
    final random = Random();
    double amount = random.nextDouble() * 1000; // Random amount between 0 and 1000
    return amount.toStringAsFixed(2);
  }

  String getRandomLimit() {
    final random = Random();
    double minLimit = random.nextDouble() * 500; // Random minimum limit between 0 and 500
    double maxLimit = minLimit + (random.nextDouble() * 500); // Random maximum limit
    return 'Rp ${minLimit.toStringAsFixed(2)} - Rp ${maxLimit.toStringAsFixed(2)}';
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF2E3339),
      elevation: 0,
      toolbarHeight: 80,
      leading: IconButton(
        icon: Image.asset('lib/images/more.png', width: 30, height: 30),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const More()),
        ),
      ),
      centerTitle: true,
      title: Image.asset('lib/images/LogoText.png', width: 90, height: 36),
      actions: [
        IconButton(
          icon: Image.asset('lib/images/notif.png', width: 30, height: 30),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButtons() {
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
              _buildTab("Buy", left: true),
              _buildTab("Sell", right: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, {bool left = true, bool right = true}) {
    final isSelected = (text == "Buy" && isBuySelected) || (text == "Sell" && !isBuySelected);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isBuySelected = (text == "Buy");
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF393E46) : const Color(0xFF222831),
            borderRadius: BorderRadius.horizontal(
              left: left ? const Radius.circular(40) : Radius.zero,
              right: right ? const Radius.circular(40) : Radius.zero,
            ),
          ),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context) {
    String randomAmount = getRandomAmount();
    String randomLimit = getRandomLimit();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const P2PTransactionDetailsPage()),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: const Color(0xFF4E5967),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adit CUCI MOTOR',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Rp $randomAmount',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  Text(
                    'Amount: $randomAmount USDT',
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  Text(
                    'Limit: $randomLimit',
                    style: const TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  const Text(
                    'Bank Transfer (Sigma, Wing Money, True Money)',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const P2PTransactionDetailsPage()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                isBuySelected ? 'BUY' : 'SELL',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3339),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'P2P Trading',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildToggleButtons(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => _buildTransactionItem(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
