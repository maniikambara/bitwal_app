import 'package:flutter/material.dart';

class PublicBlockchainAndTokenPage extends StatelessWidget {
  const PublicBlockchainAndTokenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3339),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3339),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Public Blockchain and Token',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.currency_bitcoin, size: 100, color: Colors.orange),
            const SizedBox(height: 24),
            _buildOptionTile(
              context,
              'Adding Mainnet',
              'The public blockchain, or mainnet, is the primary network for cryptocurrency transactions. It\'s where actual transactions take place and hold value.',
            ),
            _buildOptionTile(
              context,
              'Managing Multiple Mainnets',
              'If you manage multiple assets across various mainnets, you can add additional mainnets manually in the wallet settings.',
            ),
            _buildOptionTile(
              context,
              'Adding Tokens',
              'Tap "+" on the wallet homepage to manually add new tokens to your wallet from a specific mainnet.',
            ),
            _buildOptionTile(
              context,
              'Understanding USDT',
              'USDT, also known as Tether, is a stable cryptocurrency pegged to the value of the US dollar.',
            ),
            _buildOptionTile(
              context,
              'Wallet Address Explained',
              'A wallet address is a unique identifier, similar to a bank account number, used for sending and receiving cryptocurrencies.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 16),
        const Divider(color: Colors.grey),
        const SizedBox(height: 16),
      ],
    );
  }
}
