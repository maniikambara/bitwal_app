import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notification Categories Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryTab('All Notifications', true, '9+'),
                    const SizedBox(width: 8),
                    _buildCategoryTab('Transaction', false, '3'),
                    const SizedBox(width: 8),
                    _buildCategoryTab('Info', false, ''),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Notifications List
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with dynamic data count
                itemBuilder: (context, index) {
                  return _buildNotificationCard(
                    time: '01 : 00, 04 Nov 2024',
                    title: 'Bitcoin Pulls Under \$68K as Crypto Markets Falter Ahead of Election',
                    content:
                        'At least according to betting markets, the U.S. presidential election has moved to nearly a 50/50 race versus the outlook for an easy Trump victory just days ago.',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Notification Categories Tabs
  Widget _buildCategoryTab(String title, bool isActive, String badge) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF393E46) : const Color(0xFF222831),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (badge.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(left: 8.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget for Individual Notification Card
  Widget _buildNotificationCard({required String time, required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF4E5967),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
