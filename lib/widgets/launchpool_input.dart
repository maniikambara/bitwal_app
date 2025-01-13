import 'package:bitwal_app/widgets/launchpool_pendapat.dart';
import 'package:flutter/material.dart';

class LaunchpoolStakingPage extends StatelessWidget {
  const LaunchpoolStakingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222831),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Crypto Derivative Exchange',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF393E46),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.orange[800],
                    child: const Icon(Icons.currency_bitcoin, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'BTC',
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orange[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Farming',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Min. Jumlah Staking = 1 BTC',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tersedia: 1,000 BTC',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'Detail Proyek',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF393E46),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Koin Staking: BTC',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    'Total Hadiah: 1,212 BTC',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    'Periode Farming: 10 Hari',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    'Berakhir dalam: 01 D 04 H 32 M 12 S',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    'APY: 70%',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.account_balance_wallet, color: Colors.orange[800]),
              title: const Text(
                '10,121 BTC',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Total staking saya',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.card_giftcard, color: Colors.orange[800]),
              title: const Text(
                '12,142 BTC',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'Total hadiah',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push( 
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LaunchpoolEarningsPage(),
                  ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange[800],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'LANJUT',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
