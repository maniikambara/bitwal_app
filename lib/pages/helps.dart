import 'package:bitwal_app/widgets/helps_blockchain.dart';
import 'package:bitwal_app/widgets/helps_feedback.dart';
import 'package:bitwal_app/widgets/helps_swap.dart';
import 'package:bitwal_app/widgets/helps_transfer.dart';
import 'package:bitwal_app/widgets/helps_wallet.dart';
import 'package:flutter/material.dart';

class UserGuidePage extends StatelessWidget {
  const UserGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(color: Colors.white70),
                prefixIcon: const Icon(Icons.search, color: Colors.white70),
                filled: true,
                fillColor: const Color(0xFF2E3339),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Getting Started',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildListTile(context, 'Create a wallet', Icons.account_balance_wallet),
            _buildListTile(context, 'Public Blockchain and Token', Icons.token),
            _buildListTile(context, 'Transfer and Receive', Icons.swap_horiz),
            _buildListTile(context, 'Swap Trading', Icons.currency_exchange),
            _buildListTile(context, 'Give User Feedback', Icons.feedback),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, String title, IconData icon) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: Icon(icon, color: Colors.orange),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          onTap: () {
            if (title == 'Create a wallet') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateWalletPage()),
              );
            }
            if (title == 'Give User Feedback') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserFeedbackPage()),
              );
            }
            if (title == 'Public Blockchain and Token') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PublicBlockchainAndTokenPage()),
              );
            }
            if (title == 'Transfer and Receive') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TransferAndReceivePage()),
              );
            }
            if (title == 'Swap Trading') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SwapTradingTutorialPage()),
              );
            }
          },
        ),
        const Divider(color: Colors.white24),
      ],
    );
  }
}
