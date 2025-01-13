import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/widgets/order.dart';
import 'package:flutter/material.dart';

class ManyReceive extends StatefulWidget {
  const ManyReceive({super.key});

  @override
  _ManyReceiveState createState() => _ManyReceiveState();
}

class _ManyReceiveState extends State<ManyReceive> {
  List<bool> isChecked = List.generate(3, (_) => false);
  bool get isEnoughSelected => isChecked.where((element) => element).length >= 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSearchField(),
            const SizedBox(height: 20),
            _buildSelectManyReceiveContainer(),
            const SizedBox(height: 20),
            Expanded(child: _buildUserList()),
            _buildConfirmButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildSearchField() {
    return TextField(
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
    );
  }

  Widget _buildSelectManyReceiveContainer() {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF222831),
        borderRadius: BorderRadius.circular(24),
      ),
      alignment: Alignment.center,
      child: const Text(
        "Select Many Receive",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      itemCount: isChecked.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
            const SizedBox(width: 15),
            const Text(
              "TrizzKunn",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const Spacer(),
            Checkbox(
              value: isChecked[index],
              onChanged: (value) => setState(() => isChecked[index] = value!),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              activeColor: const Color(0xFFD65A31),
              checkColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: isEnoughSelected
          ? () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderPage(type: '', token: '', amount: 0, currency: '', price: 0, recipientId: '', memo: '', timestamp: DateTime.now(),)),
              )
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnoughSelected ? const Color(0xFFD65A31) : const Color(0xFF555555),
        side: BorderSide(color: isEnoughSelected ? const Color(0xFFD65A31) : const Color(0xFF555555), width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
      ),
      child: Text(
        "Confirm",
        style: TextStyle(color: isEnoughSelected ? Colors.white : const Color(0xFFAAAAAA), fontSize: 16),
      ),
    );
  }
}