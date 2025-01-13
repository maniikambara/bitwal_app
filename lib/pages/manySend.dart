import 'package:bitwal_app/pages/manyReceive.dart';
import 'package:bitwal_app/pages/oneReceive.dart';
import 'package:flutter/material.dart';

class ManySend extends StatefulWidget {
  final bool isManyToMany;
  const ManySend({super.key, required this.isManyToMany});

  @override
  _ManySendState createState() => _ManySendState();
}

class _ManySendState extends State<ManySend> {
  List<bool> isChecked = List.filled(3, false);
  bool get isEnoughChecked => isChecked.where((element) => element).length >= 2;

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
            onPressed: () {},
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
                "Select Many Sender",
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
                        radius: 20,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        "TrizzKunn",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Checkbox(
                        value: isChecked[index],
                        onChanged: (value) {
                          setState(() {
                            isChecked[index] = value!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
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
              onPressed: isEnoughChecked
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => widget.isManyToMany
                              ? const ManyReceive()
                              : const OneReceive(),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnoughChecked ? const Color(0xFFD65A31) : const Color(0xFF555555),
                side: BorderSide(
                  color: isEnoughChecked ? const Color(0xFFD65A31) : const Color(0xFF555555),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 120),
              ),
              child: Text(
                "Select Receive",
                style: TextStyle(
                  color: isEnoughChecked ? Colors.white : const Color(0xFFAAAAAA),
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}