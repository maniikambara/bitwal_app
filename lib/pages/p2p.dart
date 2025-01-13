import 'package:bitwal_app/pages/more.dart';
import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/widgets/p2pdetail.dart';
import 'package:flutter/material.dart';

class P2PTradingPage extends StatefulWidget {
  const P2PTradingPage({super.key});

  @override
  _P2PTradingPageState createState() => _P2PTradingPageState();
}

class _P2PTradingPageState extends State<P2PTradingPage> {
  bool isBuySelected = true;

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
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF4E5967),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isBuySelected = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isBuySelected ? Colors.orange : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Text(
                  'Buy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isBuySelected ? Colors.white : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => isBuySelected = false),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: !isBuySelected ? Colors.orange : Colors.transparent,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  'Sell',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: !isBuySelected ? Colors.white : Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context) {
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
                children: const [
                  Text(
                    'Adit CUCI MOTOR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Rp 0.00',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                  Text(
                    'Amount: 0.00 USDT',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  Text(
                    'Limit: Rp 0.00 - 0.00',
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                  Text(
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
