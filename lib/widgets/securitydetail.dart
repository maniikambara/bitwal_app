import 'package:flutter/material.dart';

class EditSecuritySettingsPage extends StatelessWidget {
  final String title;

  const EditSecuritySettingsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        elevation: 0,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modify $title',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Example setting toggle
            SwitchListTile(
              value: true, // Replace with dynamic state
              onChanged: (bool value) {
                // Update setting
              },
              title: const Text(
                'Enable this setting',
                style: TextStyle(color: Colors.white),
              ),
              activeColor: Colors.orange[800],
              inactiveThumbColor: Colors.white54,
              inactiveTrackColor: Colors.white24,
            ),
            const SizedBox(height: 20),
            // Save button
            ElevatedButton(
              onPressed: () {
                // Save action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800],
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Center(
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
