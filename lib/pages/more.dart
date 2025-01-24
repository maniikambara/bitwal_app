import 'package:bitwal_app/pages/helps.dart';
import 'package:bitwal_app/pages/history.dart';
import 'package:bitwal_app/pages/home.dart';
import 'package:bitwal_app/pages/launchpool.dart';
import 'package:bitwal_app/pages/marketa.dart';
import 'package:bitwal_app/pages/multitransfer.dart';
import 'package:bitwal_app/pages/p2p.dart';
import 'package:bitwal_app/pages/receive.dart';
import 'package:bitwal_app/pages/security.dart';
import 'package:bitwal_app/pages/send.dart';
import 'package:bitwal_app/pages/settings.dart';
import 'package:bitwal_app/pages/staking.dart';
import 'package:bitwal_app/pages/swap.dart';
import 'package:bitwal_app/pages/token.dart';
import 'package:bitwal_app/widgets/widget.dart';
import 'package:flutter/material.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222831),
        title: const Text(
          'More Service!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildSectionTitle('Trending'),
              const SizedBox(height: 10),
              buildIconGridMore([
                IconActionWidget(
                  imagePath: 'lib/images/send.png',
                  label: 'Send',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SendTokenPage()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/receive.png',
                  label: 'Receive',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ReceiveTokenPage()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/swap.png',
                  label: 'Swap',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SwapPage()));
                  }
                ),
              ]),
              const SizedBox(height: 10),
              buildSectionTitle('Market & Transaction'),
              const SizedBox(height: 10),
              buildIconGridMore([
                IconActionWidget(
                  imagePath: 'lib/images/buy.png',
                  label: 'Buy Crypto',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const TokenPages()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/launchpool.png',
                  label: 'Launch Pool',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LaunchPoolPage()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/stacking.png',
                  label: 'Staking',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const StakingPage()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/marketanalist.png',
                  label: 'Market Analysis',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MarketsPage()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/p2p.png',
                  label: 'Peer to Peer',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const P2PTradingPage()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/multitf.png',
                  label: 'Multi Payment',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Multitransfer()));
                  }
                ),
              ]),
              const SizedBox(height: 10),
              buildSectionTitle('Earn'),
              const SizedBox(height: 10),
              buildIconGridMore([
                IconActionWidget(
                  imagePath: 'lib/images/history.png',
                  label: 'History',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const History()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/helpsupport.png',
                  label: 'Help & Support',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserGuidePage()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/security.png',
                  label: 'Security',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SecurityPage()));
                  }
                ),
                IconActionWidget(
                  imagePath: 'lib/images/setting.png',
                  label: 'Setting',
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                  }
                ),
              ])
            ],
          ),
        ),
      )
    );
  }
}