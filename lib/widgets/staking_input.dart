import 'package:bitwal_app/widgets/staking_confirm.dart';
import 'package:flutter/material.dart';

class StakingInput extends StatefulWidget {
  const StakingInput({super.key});

  @override
  State<StakingInput> createState() => _StakingInputState();
}

class _StakingInputState extends State<StakingInput> {
  bool isAgreed = false;
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'STAKING',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stake • TRIZZ COIN',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(color: Colors.grey, height: 32),
            _buildLabel('Staking amount'),
            const SizedBox(height: 8),
            _buildAmountInput(),
            const SizedBox(height: 24),
            _buildLabel('Subscription quota'),
            const SizedBox(height: 8),
            const Text(
              'Max staking quota: No Limit',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 24),
            _buildAgreementCheckbox(),
            const Spacer(),
            _buildOrderButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white70, fontSize: 14),
    );
  }

  Widget _buildAmountInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _amountController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Min. 0.10000000 TRIZZ',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: const Color(0xFF2E3339),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            // Max button logic
            _amountController.text = '100.00000000'; // Example max amount
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.orange[800],
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          child: const Text('Max', style: TextStyle(fontSize: 16)),
        ),
      ],
    );
  }

  Widget _buildAgreementCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: isAgreed,
          onChanged: (value) {
            setState(() {
              isAgreed = value ?? false;
            });
          },
          activeColor: Colors.orange[800],
          checkColor: Colors.white,
          side: const BorderSide(color: Colors.white),
        ),
        const Expanded(
          child: Text(
            'I have read and agree to the BitWal Staking User Agreement',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderButton() {
    return ElevatedButton(
      onPressed: isAgreed
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StackingConfirmPage()),
              );
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange[800],
        disabledBackgroundColor: const Color(0xFF393E46),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'Order',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
