import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/pages/send.dart';
import 'package:bitwal_app/widgets/receivedetail.dart';
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

  final List<Map<String, dynamic>> userTokens = [
    {'name': 'BTC', 'fullName': 'Bitcoin', 'amount': 0.5, 'price': 450000000},
    {'name': 'ETH', 'fullName': 'Ethereum', 'amount': 2.0, 'price': 30000000},
    {'name': 'ADA', 'fullName': 'Cardano', 'amount': 1000.0, 'price': 7500},
    {'name': 'DOT', 'fullName': 'Polkadot', 'amount': 100.0, 'price': 150000},
    {'name': 'XRP', 'fullName': 'Ripple', 'amount': 5000.0, 'price': 9000},
  ];

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
      builder: (context) => _FilterSheet(),
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
}

class _FilterSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: SizedBox(width: 100, child: Divider(thickness: 3, color: Colors.white)),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text('FILTER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: const [
                FilterOption(title: 'Token Terbaru'),
                FilterOption(title: 'Token Favorit'),
                FilterOption(title: 'Token Meme'),
                FilterOption(title: 'Token Gaming'),
                FilterOption(title: 'Token AI & Big Data'),
                FilterOption(title: 'Token DoFi'),
                FilterOption(title: 'Token Layer 1'),
                FilterOption(title: 'Token Layer 2'),
                FilterOption(title: 'Token NFT'),
                FilterOption(title: 'Token Web3'),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD65A31),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Center(
              child: Text('TERAPKAN', style: TextStyle(color: Color(0xFF222831), fontWeight: FontWeight.bold, fontSize: 24)),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterOption extends StatelessWidget {
  final String title;
  const FilterOption({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Radio(
            value: title,
            groupValue: null,
            onChanged: (value) {},
            activeColor: const Color(0xFFD65A31),
          ),
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}