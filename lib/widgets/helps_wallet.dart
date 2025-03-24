import 'package:flutter/material.dart';

class CreateWalletPage extends StatelessWidget {
  const CreateWalletPage({super.key});

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
          'Create a Wallet',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.account_balance_wallet, size: 100, color: Colors.orange),
            const SizedBox(height: 24),
            const Text(
              'Welcome to BiWal Wallet Creation',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'Follow these steps to create and secure your wallet:',
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _buildStepTile(context, '1. Create a Mnemonic Wallet', 'Start by creating a secure mnemonic wallet.'),
            _buildStepTile(context, '2. Backup Mnemonic Phrase', 'Securely store your mnemonic phrase offline.'),
            _buildStepTile(context, '3. Create a Keyless Wallet', 'Set up an MPC wallet for enhanced security.'),
            _buildStepTile(context, '4. Backup Keyless Wallet', 'Ensure your keyless wallet is properly backed up.'),
            _buildStepTile(context, '5. Understand Wallet Address', 'Learn about your unique wallet identifier.'),
          ],
        ),
      ),
    );
  }

  Widget _buildStepTile(BuildContext context, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF393E46),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.5), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange, size: 20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TutorialStepPage(title: title, description: description),
            ),
          );
        },
      ),
    );
  }
}

class TutorialStepPage extends StatelessWidget {
  final String title;
  final String description;

  const TutorialStepPage({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E3339),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E3339),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Detailed instructions will be provided here.',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
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
        _buildInstructionStep('2. Navigate to the Swap section in the main menu.'),
        _buildInstructionStep('3. Follow the on-screen prompts to complete the process.'),
        _buildInstructionStep('4. Review all details carefully before confirming.'),
        _buildInstructionStep('5. If you need help, contact our support team.'),
      ],
    );
  }

  Widget _buildInstructionStep(String step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        step,
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }
}