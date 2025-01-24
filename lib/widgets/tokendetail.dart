import 'package:bitwal_app/pages/home.dart';
import 'package:bitwal_app/widgets/buytoken.dart';
import 'package:bitwal_app/widgets/selltoken.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitwal_app/services/auth_service.dart';
import 'package:bitwal_app/models/token.dart';
import 'package:intl/intl.dart';

class TokenDetails extends StatelessWidget {
  const TokenDetails({
    super.key,
    required this.tokenAbbr,
  });

  final String tokenAbbr;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

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
        final token = tokens.firstWhere(
          (t) => t.abbreviation == tokenAbbr,
          orElse: () => Token(
            name: '',
            abbreviation: tokenAbbr,
            price: 0,
            icon: '',
            amount: 0,
          ),
        );

        // Calculate values
        final bestBid = token.price * 0.98;
        final bestAsk = token.price * 1.02;
        final change = token.price * 0.05; // Example change value
        final changePercent = 5.0; // Example change percentage

        return Scaffold(
          backgroundColor: const Color(0xFF222831),
          appBar: AppBar(
            backgroundColor: const Color(0xFF222831),
            elevation: 0,
            toolbarHeight: 80,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                              token.icon,
                              width: 80,
                              height: 80,
                            ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                token.abbreviation,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                token.name,
                                style: const TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currencyFormat.format(token.price),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Best Bid : ${currencyFormat.format(bestBid)}',
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      Text(
                        'Best Ask : ${currencyFormat.format(bestAsk)}',
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${change >= 0 ? '+' : '-'}${currencyFormat.format(change.abs())} (${changePercent.abs().toStringAsFixed(2)}%)',
                    style: TextStyle(
                      color: change >= 0 ? Colors.green : Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF393E46),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                  token.icon,
                                  width: 50,
                                  height: 50,
                                ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    token.abbreviation,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${NumberFormat.compact().format(token.amount)} ${token.abbreviation}',
                                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 24),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  const Text(
                    'Your Position',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildPositionInfo('Total', '${NumberFormat.compact().format(token.amount)} ${token.abbreviation}'),
                  buildPositionInfo('Market Price', currencyFormat.format(token.price * token.amount)),
                  buildPositionInfo('Average Buy Price', currencyFormat.format(token.price * 0.95)),
                  buildPositionInfo('P&L Hari Ini', '-${currencyFormat.format(change)}', isProfit: false),
                  buildPositionInfo(
                    'Unrealized P&L',
                    '+${currencyFormat.format(token.price * token.amount * 0.05)} (5%)',
                    isProfit: true,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'About Token',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  const Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(
                        'Bitcoin (BTC) adalah cryptocurrency pertama di dunia yang diciptakan pada tahun 2009 oleh individu atau kelompok anonim dengan nama samaran Satoshi Nakamoto. Bitcoin dirancang sebagai mata uang digital terdesentralisasi yang memungkinkan transaksi peer-to-peer tanpa memerlukan perantara seperti bank atau institusi lainnya.',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            decoration: const BoxDecoration(
              color: Color(0xFF222831),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuyToken(tokenAbbr: token.abbreviation)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Buy',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SellToken(tokenAbbr: token.abbreviation, name: token.name)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Sell',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildPositionInfo(String title, String value, {bool isProfit = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            value,
            style: TextStyle(
              color: title.contains('P&L') ? (isProfit ? Colors.green : Colors.red) : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionButton(String text, BuildContext context, Color backgroundColor, {Color? textColor, Color? borderColor}) {
    return ElevatedButton(
      onPressed: () {
        if (text == 'BUY') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BuyToken(tokenAbbr: tokenAbbr)),
          );
        } else if (text == 'SELL') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SellToken(tokenAbbr: tokenAbbr, name: tokenAbbr)),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: borderColor != null ? BorderSide(color: borderColor, width: 2) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }
}