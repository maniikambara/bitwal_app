import 'package:bitwal_app/widgets/filtertoken.dart';
import 'package:bitwal_app/widgets/tokendetail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitwal_app/services/auth_service.dart';
import 'package:bitwal_app/models/token.dart';
import 'package:intl/intl.dart';

class TokenPages extends StatefulWidget {
  const TokenPages({super.key});

  @override
  State<TokenPages> createState() => _TokenPagesState();
}

class _TokenPagesState extends State<TokenPages> {
  String selectedRange = '1 Hari';
  bool isExtended = false;
  final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildHeader(),
          _buildTokenListHeader(),
          const Divider(color: Colors.grey, thickness: 2),
          Expanded(child: _buildTokenList()),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFloatingActionButton(),
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
          onPressed: () {
            // Notification action
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white, size: 40),
            onPressed: () => _showFilterSheet(),
          ),
          const SizedBox(width: 8),
          const Text(
            'C R Y P T O',
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenListHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Token',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Price',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTokenList() {
    return StreamBuilder<List<Token>>(
      stream: context.read<AuthService>().availableTokens,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final tokens = snapshot.data ?? [];
        return ListView.builder(
          itemCount: tokens.length,
          itemBuilder: (context, index) {
            final token = tokens[index];
            // Simulate price change percentage (you might want to store this in Firebase)
            final isProfit = index % 2 == 0;
            final percent = isProfit ? 5 : -3;
            return _buildTokenListItem(token, isProfit, percent);
          },
        );
      },
    );
  }

  Widget _buildTokenListItem(Token token, bool isProfit, int percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: GestureDetector(
        onTap: () => _navigateToTokenDetails(token),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTokenInfo(token),
            _buildTokenPrice(token.price, isProfit, percent),
          ],
        ),
      ),
    );
  }

  Widget _buildTokenInfo(Token token) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(token.icon),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              token.abbreviation,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              token.name,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTokenPrice(double price, bool isProfit, int percent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          currencyFormat.format(price),
          style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          '${isProfit ? '+' : ''}$percent%',
          style: TextStyle(
            color: isProfit ? Colors.green : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFloatingActionButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isExtended) _buildRangeSelector(),
        FloatingActionButton.extended(
          onPressed: () => setState(() => isExtended = !isExtended),
          backgroundColor: const Color(0xFF222831),
          label: Text(
            'Rentang Waktu: $selectedRange',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildRangeSelector() {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF222831),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRangeOption('1 Hari'),
          _buildRangeOption('1 Minggu'),
          _buildRangeOption('1 Bulan'),
          _buildRangeOption('1 Tahun'),
        ],
      ),
    );
  }

  Widget _buildRangeOption(String range) {
    final isSelected = selectedRange == range;
    return GestureDetector(
      onTap: () => setState(() {
        selectedRange = range;
        isExtended = false;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            if (isSelected)
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFD65A31),
                  shape: BoxShape.circle,
                ),
              ),
            SizedBox(width: isSelected ? 8 : 18),
            Text(
              range,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const TokenFilterSheet(),
    );
  }

  void _navigateToTokenDetails(Token token) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TokenDetails(tokenAbbr: token.abbreviation),
      ),
    );
  }
}