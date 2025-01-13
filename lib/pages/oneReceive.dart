import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/widgets/order.dart';
import 'package:flutter/material.dart';

class OneReceive extends StatefulWidget {
  const OneReceive({super.key});

  @override
  _OneReceiveState createState() => _OneReceiveState();
}

class _OneReceiveState extends State<OneReceive> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFD9D9D9),
                hintText: "Search Username",
                hintStyle: const TextStyle(color: Color(0xFF393E46)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Color(0xFF393E46)),
              ),
              style: const TextStyle(color: Color(0xFF393E46), fontSize: 16.0),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF222831),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Select One Receive",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('lib/images/Logo.png'),
                        radius: 24,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "TrizzKunn",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Checkbox(
                        value: selectedIndex == index,
                        onChanged: (value) => setState(() =>
                            selectedIndex = value! ? index : null),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: const Color(0xFFD65A31),
                        checkColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: selectedIndex != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OrderPage(type: '', token: '', amount: 0, currency: '', price: 0, recipientId: '', memo: '', timestamp: DateTime.now(),)),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedIndex != null
                    ? const Color(0xFFD65A31)
                    : const Color(0xFF555555),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
              ),
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: selectedIndex != null
                      ? Colors.white
                      : const Color(0xFFAAAAAA),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}