import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/pages/qrscan.dart';
import 'package:bitwal_app/pages/receive.dart';
import 'package:bitwal_app/pages/send.dart';
import 'package:bitwal_app/pages/token.dart';
import 'package:bitwal_app/pages/more.dart';
import 'package:bitwal_app/pages/settings.dart';
import 'package:bitwal_app/pages/settings_user.dart';
import 'package:bitwal_app/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitwal_app/services/auth_service.dart';
import 'package:bitwal_app/models/user.dart';
import 'package:bitwal_app/models/token.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isBalanceVisible = true;
  List<Map<String, String>> newsArticles = []; // List to hold the fetched news articles

  // Constant for color
  static const Color backgroundColor = Color(0xFF393E46);

  void _toggleBalanceVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(amount);
  }

  // Fetch news from NewsAPI
  Future<void> fetchNews() async {
    final url = 'https://newsapi.org/v2/everything?q=crypto&apiKey=f709e2ffa117411cb17fb91a17f785a8'; // Use your NewsAPI key

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Safely handle dynamic types and convert them to the correct map type
        setState(() {
          newsArticles = List<Map<String, String>>.from(
            data['articles'].map<Map<String, String>>((article) {
              return {
                'author': article['author'] ?? 'Unknown',
                'title': article['title'] ?? 'No title',
                'content': article['content'] ?? 'No content available',
                'url': article['url'] ?? '',
              };
            }).toList(),
          );
        });
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();  // Fetch news when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: context.read<AuthService>().user,
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: backgroundColor,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (userSnapshot.hasError) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: Text(
                'Error loading user data: ${userSnapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        final user = userSnapshot.data;
        if (user == null) {
          return Scaffold(
            backgroundColor: backgroundColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'No user data available',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        }

        return StreamBuilder<List<Token>>(
          stream: context.read<AuthService>().availableTokens,
          builder: (context, tokensSnapshot) {
            if (tokensSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                backgroundColor: backgroundColor,
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (tokensSnapshot.hasError) {
              return Scaffold(
                backgroundColor: backgroundColor,
                body: Center(
                  child: Text(
                    'Error loading tokens: ${tokensSnapshot.error}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }

            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: backgroundColor,
              appBar: AppBar(
                backgroundColor: backgroundColor,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'lib/images/setting.png',
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SettingsPage()),
                        );
                      },
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Row(
                          children: [
                            SizedBox(width: 8),
                            Icon(Icons.search, color: Color(0xFF393E46)),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle: TextStyle(color: Color(0xFF393E46)),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Image.asset(
                        'lib/images/scan.png',
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const QRScanPage()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Image.asset(
                        'lib/images/notif.png',
                        width: 40,
                        height: 40,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationsPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileSettingsPage()),
                        );
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage('lib/images/Logo.png'),
                            radius: 20,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            user.username,
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: _toggleBalanceVisibility,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  _isBalanceVisible ? formatCurrency(user.balance) : '************',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            if (_isBalanceVisible)
                              const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '+Rp.12,000,000 (+10%) Today',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    buildIconGrid([
                      IconActionWidget(
                        imagePath: 'lib/images/send.png',
                        label: 'Send',
                        iconSize: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SendTokenPage()),
                          );
                        },
                      ),
                      IconActionWidget(
                        imagePath: 'lib/images/receive.png',
                        label: 'Receive',
                        iconSize: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ReceiveTokenPage()),
                          );
                        },
                      ),
                      IconActionWidget(
                        imagePath: 'lib/images/buy.png',
                        label: 'Buy Crypto',
                        iconSize: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const TokenPages()),
                          );
                        },
                      ),
                      IconActionWidget(
                        imagePath: 'lib/images/more.png',
                        label: 'More',
                        iconSize: 50,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const More()),
                          );
                        },
                      ),
                    ]),
                    const SizedBox(height: 20),
                    Text(
                      'Latest Crypto News',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: newsArticles.length,
                        itemBuilder: (context, index) {
                          final article = newsArticles[index];
                          return ListTile(
                            title: Text(article['title']!, style: const TextStyle(color: Colors.white)),
                            subtitle: Text(article['author']!, style: const TextStyle(color: Colors.white70)),
                            trailing: const Icon(Icons.arrow_forward, color: Colors.white),
                            onTap: () {
                              // Handle the article tap, e.g., navigate to the article's URL
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
