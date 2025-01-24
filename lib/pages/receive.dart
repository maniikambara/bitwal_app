import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/pages/send.dart';
import 'package:bitwal_app/widgets/receivedetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceiveTokenPage extends StatefulWidget {
  const ReceiveTokenPage({super.key});

  @override
  State<ReceiveTokenPage> createState() => _ReceiveTokenPageState();
}

class _ReceiveTokenPageState extends State<ReceiveTokenPage> {
  String selectedRange = '1 Hari';
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
  List<Map<String, dynamic>> userTokens = [];

  @override
  void initState() {
    super.initState();
    _fetchUserTokens();
  }

  // Fetch user's tokens from Firestore
  Future<void> _fetchUserTokens() async {
    try {
      String currentUserId = _getCurrentUserId();
      
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .get();

      if (userDoc.exists) {
        var data = userDoc.data() as Map<String, dynamic>;
        var tokensList = List<Map<String, dynamic>>.from(data['tokens'] ?? []);
        
        setState(() {
          userTokens = tokensList;
        });
      }
    } catch (e) {
      print('Error fetching user tokens: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildToggleButtons(),
          _buildFilterAndRange(),
          _buildTokenListHeader(),
          const Divider(color: Colors.grey, thickness: 2),
          Expanded(child: _buildTokenList()),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF393E46),
      elevation: 0,
      toolbarHeight: 100,
      leading: IconButton(
        icon: Image.asset('lib/images/more.png', width: 40, height: 40),
        onPressed: () => Navigator.pop(context),
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

  Widget _buildToggleButtons() {
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
              _buildTab("Crypto Send", left: true),
              _buildTab("Receive", right: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, {bool left = true, bool right = false}) {
    final isSelected = text == "Receive";
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isSelected) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SendTokenPage()));
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.all(8.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF393E46) : const Color(0xFF222831),
            borderRadius: BorderRadius.horizontal(
              left: left ? const Radius.circular(40) : Radius.zero,
              right: right ? const Radius.circular(40) : Radius.zero,
            ),
          ),
          child: Text(text, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildFilterAndRange() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: _showFilterSheet,
            icon: const Icon(Icons.filter_list, color: Colors.white),
            label: const Text('Filter', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF222831),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          GestureDetector(
            onTap: _showRangeSelector,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF222831),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(selectedRange, style: const TextStyle(color: Colors.white, fontSize: 16)),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenListHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Token', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          Text('Balance', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTokenList() {
    return ListView.builder(
      itemCount: userTokens.length,
      itemBuilder: (context, index) {
        final token = userTokens[index];
        return _buildTokenListItem(token);
      },
    );
  }

  Widget _buildTokenListItem(Map<String, dynamic> token) {
    final balance = token['amount'] * token['price'];
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TokenReceiveDetailsPage(token: token['name'], price: token['price'])),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTokenInfo(token),
            _buildTokenBalance(balance),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenInfo(Map<String, dynamic> token) {
    return Row(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Colors.orange,
          child: Text(
            token['name'],
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              token['name'],
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(token['fullName'], style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ],
    );
  }

  Widget _buildTokenBalance(double balance) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          currencyFormat.format(balance),
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: const Color(0xFF222831),
      builder: (context) => const _FilterSheet(),
    );
  }

  void _showRangeSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: const Color(0xFF222831),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: ['1 Hari', '1 Minggu', '1 Bulan'].map((range) {
          return ListTile(
            title: Text(range, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
            onTap: () {
              setState(() => selectedRange = range);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }

  String _getCurrentUserId() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw 'No authenticated user found';
    }
    return user.uid;
  }
}

class _FilterSheet extends StatelessWidget {
  const _FilterSheet();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: const [
          _FilterOption(text: 'A'),
          _FilterOption(text: 'B'),
          _FilterOption(text: 'C'),
        ],
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String text;

  const _FilterOption({required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
