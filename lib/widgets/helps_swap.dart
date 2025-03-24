import 'package:flutter/material.dart';

class SwapTradingTutorialPage extends StatelessWidget {
  const SwapTradingTutorialPage({super.key});

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
          'Swap Trading Tutorial',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.swap_horiz, size: 100, color: Colors.orange),
            ),
            const SizedBox(height: 24),
            const Text(
              'Learn how to perform Swap Trading',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Follow these steps to start swapping tokens:',
              style: TextStyle(color: Colors.white70, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildStepTile(
              context,
              'Step 1: Access Swap Feature',
              'Open the BiWal app and navigate to the "Swap" section in the main menu.',
              Icons.open_in_new,
            ),
            _buildStepTile(
              context,
              'Step 2: Choose Tokens to Swap',
              'Select the token you want to swap from and the token you want to swap to.',
              Icons.compare_arrows,
            ),
            _buildStepTile(
              context,
              'Step 3: Enter Swap Amount',
              'Enter the amount of the token you want to swap. Ensure you have sufficient balance.',
              Icons.attach_money,
            ),
            _buildStepTile(
              context,
              'Step 4: Review Swap Details',
              'Review the swap details, including fees and exchange rates, before confirming the swap.',
              Icons.rate_review,
            ),
            _buildStepTile(
              context,
              'Step 5: Confirm the Swap',
              'Tap the "Confirm" button to execute the swap. The swapped token will appear in your wallet.',
              Icons.check_circle_outline,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepTile(BuildContext context, String title, String description, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF393E46),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.5), width: 1),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        leading: Icon(icon, color: Colors.orange, size: 28),
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
              builder: (context) => TutorialStepDetailPage(title: title, description: description, icon: icon),
            ),
          );
        },
      ),
    );
  }
}

class TutorialStepDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const TutorialStepDetailPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

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
          style: const TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(icon, size: 80, color: Colors.orange),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 32),
            const Text(
              'Detailed Instructions:',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
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
        _buildInstructionStep('2. Navigate to the Swap section in the main menu.'),
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
          const Icon(Icons.check_circle, color: Colors.orange, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              instruction,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
