import 'package:bitwal_app/pages/more.dart';
import 'package:bitwal_app/pages/notif.dart';
import 'package:flutter/material.dart';

class MarketsPage extends StatelessWidget {
  const MarketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 20),
            _buildMarketTabs(),
            const SizedBox(height: 20),
            _buildMarketTrendIndicator(),
            const SizedBox(height: 20),
            _buildFavoritesAndAllFilters(),
            const SizedBox(height: 10),
            _buildFilterChips(),
            const SizedBox(height: 20),
            _buildMarketList(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF393E46),
      elevation: 0,
      toolbarHeight: 100,
      leading: IconButton(
        icon: Image.asset('lib/images/more.png', width: 40, height: 40),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const More()),
        ),
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

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Color(0xFF393E46)),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Color(0xFF393E46)),
        ),
      ),
    );
  }

  Widget _buildMarketTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMarketCard('BTC', '\$97,601.39', '+1.24%', true),
        _buildMarketCard('ETH', '\$2,801.39', '-0.54%', false),
        _buildMarketCard('BNB', '\$301.39', '+2.14%', false),
      ],
    );
  }

  Widget _buildMarketTrendIndicator() {
    return Row(
      children: [
        Expanded(
          flex: 7,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritesAndAllFilters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'All',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Wrap(
      spacing: 10,
      children: [
        _buildFilterChip('All', true),
        _buildFilterChip('Ethereum', false),
        _buildFilterChip('BNB', false),
        _buildFilterChip('Solana', false),
      ],
    );
  }

  Widget _buildMarketList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildMarketItem('JUSTICE', '\$18.90M', '\$18.90', index % 2 == 0);
        },
      ),
    );
  }

  Widget _buildMarketCard(String symbol, String price, String change, bool isActive) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4E5967) : const Color(0xFF393E46),
        borderRadius: BorderRadius.circular(10),
        border: isActive
            ? Border.all(color: Colors.green, width: 2)
            : Border.all(color: Colors.transparent),
      ),
      child: Column(
        children: [
          Text(
            symbol,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            price,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Text(
            change,
            style: TextStyle(
              color: change.startsWith('+') ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.orange[800] : const Color(0xFF4E5967),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : Colors.white54,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMarketItem(String name, String marketCap, String price, bool isPositive) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF4E5967),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(Icons.monetization_on, color: Colors.orange),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    marketCap,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            price,
            style: TextStyle(
              color: isPositive ? Colors.green : Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
