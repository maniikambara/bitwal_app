import 'package:bitwal_app/pages/home.dart';
import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/pages/qrscan.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QRShowPage extends StatefulWidget {
  const QRShowPage({super.key});

  @override
  State<QRShowPage> createState() => _QRShowPageState();
}

class _QRShowPageState extends State<QRShowPage> {
  String selectedToken = 'BTC';
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToggleButtons(context),
          const SizedBox(height: 80),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Untuk melakukan pembayaran dengan QR\nsilahkan tunjukkan kode QR ini.',
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4E5967),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Address: $userId',
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, color: Colors.white54),
                              onPressed: () {
                                // Add clipboard functionality here
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                color: const Color(0xFF393E46),
                                child: ListView(
                                  children: ['BTC', 'ETH', 'LTC', 'XRP'].map((token) {
                                    return ListTile(
                                      title: Text(token, style: const TextStyle(color: Colors.white)),
                                      onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          selectedToken = token;
                                        });
                                      },
                                    );
                                  }).toList(),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4E5967),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Token : $selectedToken',
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_drop_down, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
              _buildTab("QR Scan", context, left: true),
              _buildTab("QR Show", context, right: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, BuildContext context, {bool left = true, bool right = false}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (text == "QR Scan") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const QRScanPage()));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: text == "QR Scan" ? const Color(0xFF222831) : const Color(0xFF393E46),
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
}
