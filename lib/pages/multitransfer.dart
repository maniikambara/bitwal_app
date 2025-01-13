import 'package:bitwal_app/pages/manySend.dart';
import 'package:bitwal_app/pages/oneSend.dart';
import 'package:flutter/material.dart';

class Multitransfer extends StatefulWidget {
  const Multitransfer({super.key});

  @override
  _MultitransferState createState() => _MultitransferState();
}

class _MultitransferState extends State<Multitransfer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        elevation: 0,
        toolbarHeight: 50,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
          ),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/images/multitflogo.png", width: 200, height: 200),
            const SizedBox(height: 10),
            const Text(
              'Multi Transfer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 80),
            TransferButton(
              icon: Image.asset("lib/images/oneTomany.png", width: 40, height: 40),
              text: 'One to Many',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OneSend()),
                );
              },
            ),
            const SizedBox(height: 20),
            TransferButton(
              icon: Image.asset("lib/images/manyToone.png", width: 40, height: 40),
              text: 'Many to One',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManySend(isManyToMany: false,)),
                );
              },
            ),
            const SizedBox(height: 20),
            TransferButton(
              icon: Image.asset("lib/images/manyTomany.png", width: 24, height: 40),
              text: 'Many to Many',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ManySend(isManyToMany: true,)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TransferButton extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onPressed;

  const TransferButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Padding(
        padding: const EdgeInsets.only(right: 40),
        child: icon,
      ),
      label: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF393E46),
        ),
      ),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFD65A31),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}