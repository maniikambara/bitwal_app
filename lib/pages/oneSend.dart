import 'package:bitwal_app/pages/manyReceive.dart';
import 'package:bitwal_app/pages/oneReceive.dart';
import 'package:flutter/material.dart';

class OneSend extends StatefulWidget {
  const OneSend({super.key});

  @override
  _OneSendState createState() => _OneSendState();
}

class _OneSendState extends State<OneSend> {
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
              // Notification action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                "Select One Sender",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage('lib/images/Logo.png'),
                      radius: 24,
                    ),
                    title: const Text(
                      "TrizzKunn",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: Checkbox(
                      value: selectedIndex == index,
                      onChanged: (value) => setState(() => selectedIndex = value! ? index : null),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      activeColor: const Color(0xFFD65A31),
                      checkColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedIndex != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => selectedIndex == 0 ? const OneReceive() : const ManyReceive(),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedIndex != null ? const Color(0xFFD65A31) : const Color(0xFF555555),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
              ),
              child: Text(
                "Select Recipient",
                style: TextStyle(
                  color: selectedIndex != null ? Colors.white : const Color(0xFFAAAAAA),
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