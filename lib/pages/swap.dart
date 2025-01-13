import 'package:bitwal_app/pages/convert.dart';
import 'package:bitwal_app/pages/more.dart';
import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/widgets/verifikasi.dart';
import 'package:flutter/material.dart';

class SwapPage extends StatefulWidget {

  const SwapPage({super.key});

  @override
  _SwapPageState createState() => _SwapPageState();
}

class _SwapPageState extends State<SwapPage> {
  String fromCurrency = 'ETH';
  String toCurrency = 'USDT';
  String fromAmount = '1';
  String toAmount = '1,990';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildToggleButtons(context),
              const SizedBox(height: 20),
              _buildCryptoSwapTitle(),
              const SizedBox(height: 10),
              _buildSwapInterface(context),
              const SizedBox(height: 20),
              _buildBalanceText(),
              const Spacer(),
              _buildSwapButton(context),
              const SizedBox(height: 25),
            ],
          ),
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

  Widget _buildToggleButtons(BuildContext context) {
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
              _buildTab("Crypto Swap", context, left: true),
              _buildTab("Crypto to Currency", context, right: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String text, BuildContext context, {bool left = false, bool right = true}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            if (text == "Crypto to Currency") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ConvertPage()));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: text == "Crypto to Currency" ? const Color(0xFF222831) : const Color(0xFF393E46),
              borderRadius: BorderRadius.horizontal(
                left: left ? const Radius.circular(40) : Radius.zero,
                right: right ? const Radius.circular(40) : Radius.zero,
              ),
            ),
            child: Text(text, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildCryptoSwapTitle() {
    return const Text(
      "Crypto Swap",
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Satoshi',
      ),
    );
  }

  Widget _buildSwapInterface(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _buildCurrencyContainer(fromAmount, fromCurrency, "\$2,500.10"),
            const SizedBox(height: 10),
            _buildCurrencyContainer(toAmount, toCurrency, "\$2,500.75 (+0.056%)"),
          ],
        ),
        Positioned(
          top: 96,
          left: MediaQuery.of(context).size.width / 2 - 33,
          child: _buildSwapIcon(),
        ),
      ],
    );
  }

  Widget _buildCurrencyContainer(String amount, String currency, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF222831),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                amount,
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
              DropdownButton<String>(
                value: currency,
                items: ['ETH', 'USDT', 'BTC'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(color: Colors.white)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    if (currency == fromCurrency) {
                      fromCurrency = newValue!;
                    } else {
                      toCurrency = newValue!;
                    }
                  });
                },
                dropdownColor: const Color(0xFF222831),
                iconEnabledColor: Colors.white,
                underline: const SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildSwapIcon() {
    return GestureDetector(
      onTap: () {
        setState(() {
          String tempCurrency = fromCurrency;
          fromCurrency = toCurrency;
          toCurrency = tempCurrency;

          String tempAmount = fromAmount;
          fromAmount = toAmount;
          toAmount = tempAmount;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF393E46), width: 4.0),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const RotatedBox(
          quarterTurns: 1,
          child: Image(
            image: AssetImage('lib/images/swap.png'),
            fit: BoxFit.cover,
            width: 38,
            height: 38,
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceText() {
    return const Text(
      "Your Balance Wallet Now: 10 ETH",
      style: TextStyle(color: Colors.white, fontSize: 16),
    );
  }

  Widget _buildSwapButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifikasiPage(
                      type: '',
                      token: '',
                      amount: 0,
                      recipientId: '',
                      memo: '',
                      timestamp: DateTime.now(),
                    ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFD65A31),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          "SWAP",
          style: TextStyle(
            color: Color(0xFF393E46),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
