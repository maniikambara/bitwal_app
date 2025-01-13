import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitwal_app/services/auth_service.dart';

class TokenReceiveDetailsPage extends StatelessWidget {
  final String token;
  final int price;

  const TokenReceiveDetailsPage({super.key, required this.token, required this.price});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

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
        title: Text(
          '$token Receive',
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.orange,
            child: Text(
              token.substring(0, 1),
              style: const TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '$token Receive',
            style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Icon(Icons.qr_code_2_sharp, size: 160, color: Colors.white),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: const Color(0xFF393E46),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    user?.uid ?? 'No user ID available',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Logic for copying address
                  },
                  icon: const Icon(Icons.copy, color: Colors.orange),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSocialButton(Icons.whatshot, 'WhatsApp'),
                _buildSocialButton(Icons.telegram, 'Telegram'),
                _buildSocialButton(Icons.facebook, 'Facebook'),
                _buildSocialButton(Icons.email, 'Gmail'),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFF393E46),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
