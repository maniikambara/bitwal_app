import 'package:bitwal_app/pages/home.dart';
import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/pages/qrshow.dart';
import 'package:flutter/material.dart';

class QRScanPage extends StatelessWidget {
  const QRScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToggleButtons(context),
          const SizedBox(height: 20),
          _buildQRScanContainer(),
          _buildGalleryButton(),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF393E46),
      elevation: 0,
      toolbarHeight: 100,
      leading: IconButton(
        icon: Image.asset('lib/images/more.png', width: 40, height: 40),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        ),
      ),
      centerTitle: true,
      title: Image.asset('lib/images/LogoText.png', width: 100, height: 40),
      actions: [
        IconButton(
          icon: Image.asset('lib/images/notif.png', width: 40, height: 40),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildToggleButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF222831),
            borderRadius: BorderRadius.circular(40),
          ),
          child: Row(
            children: [
              _buildTab(context, "QR Scan", left: true),
              _buildTab(context, "QR Show", right: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String text, {bool left = false, bool right = true}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (text == "QR Show") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const QRShowPage()));
            }
            // Add QR scan functionality here if needed
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: text == "QR Show" ? const Color(0xFF222831) : const Color(0xFF393E46),
              borderRadius: BorderRadius.horizontal(
                left: left ? const Radius.circular(40) : Radius.zero,
                right: right ? const Radius.circular(40) : Radius.zero,
              ),
            ),
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildQRScanContainer() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(64.0),
        decoration: BoxDecoration(
          color: const Color(0xFF222831),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text(
            'QR Scan functionality is temporarily unavailable',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildGalleryButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF4E5967),
          onPressed: () {
            // Handle gallery action (e.g., pick image from gallery)
          },
          child: const Icon(Icons.image, color: Colors.white54),
        ),
      ),
    );
  }
}
