import 'package:flutter/material.dart';

class TransferAndReceivePage extends StatefulWidget {
  const TransferAndReceivePage({super.key});

  @override
  State<TransferAndReceivePage> createState() => _TransferAndReceivePageState();
}

class _TransferAndReceivePageState extends State<TransferAndReceivePage> {
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
          'Transfer and Receive',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.swap_horiz, size: 100, color: Colors.orange),
            const SizedBox(height: 24),
            const Text(
              'Transfer and Receive Guide',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildOptionTile(
              context,
              'Transfer from Exchange',
              'Open BitWal Exchange, go to "Assets," select token, tap "Withdraw," enter wallet address.',
            ),
            _buildOptionTile(
              context,
              'Receive Tokens',
              'Identify token mainnet, provide correct wallet address to sender, verify accuracy.',
            ),
            _buildOptionTile(
              context,
              'Send Tokens',
              'Confirm mainnet, get recipient\'s address, use wallet app to enter address and amount.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF393E46),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            description,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailedTutorialPage(title: title),
            ),
          );
        },
      ),
    );
  }
}

class DetailedTutorialPage extends StatelessWidget {
  final String title;

  const DetailedTutorialPage({super.key, required this.title});

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
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detailed Instructions for $title',
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildDetailedInstructions(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInstructionStep('1. Open the BiWal app on your device.'),
        _buildInstructionStep('2. Navigate to the $title section in the main menu.'),
        _buildInstructionStep('3. Follow the on-screen prompts to complete the process.'),
        _buildInstructionStep('4. Review all details carefully before confirming.'),
        _buildInstructionStep('5. If you need help, contact our support team.'),
      ],
    );
  }

  Widget _buildInstructionStep(String instruction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
