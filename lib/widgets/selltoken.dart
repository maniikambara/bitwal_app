import 'package:bitwal_app/widgets/order.dart';
import 'package:flutter/material.dart';

class SellToken extends StatefulWidget {
  const SellToken({super.key, required this.name, required String tokenAbbr});
  final String name;

  @override
  State<SellToken> createState() => _SellTokenState();
}

class _SellTokenState extends State<SellToken> {
  String selectedCurrency = 'IDR';
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222831),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF222831),
        elevation: 0,
        toolbarHeight: 100,
        title: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              'SELL ${widget.name}',
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
              ),
              child: DropdownButton<String>(
                value: selectedCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrency = newValue!;
                  });
                },
                dropdownColor: const Color(0xFF393E46),
                items: <String>['IDR', 'BTC'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        if (value == selectedCurrency)
                          Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD65A31),
                              shape: BoxShape.circle,
                            ),
                          ),
                        const SizedBox(width: 8),
                        Text(value, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedCurrency,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  amount.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              selectedCurrency == 'BTC'
                  ? '${(amount * 98765421).toStringAsFixed(0)} IDR'
                  : '${(amount / 98765421).toStringAsFixed(8)} BTC',
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildAmountButton(100),
                buildAmountButton(500),
                buildAmountButton(1000),
                buildAmountButton(5000),
                buildAmountButton(10000),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  if (index == 9) {
                    return buildKeyPadButton('00');
                  } else if (index == 10) {
                    return buildKeyPadButton('0');
                  } else if (index == 11) {
                    return buildKeyPadButton('<');
                  } else {
                    return buildKeyPadButton((index + 1).toString());
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderPage(type: '', token: '', amount: 0, currency: '', price: 0, recipientId: '', memo: '', timestamp: DateTime.now(),)
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD65A31),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'REVIEW ORDER',
                style: TextStyle(
                  color: Color(0xFF222831),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAmountButton(int value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          amount += value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF393E46),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKeyPadButton(String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (value == '<') {
            if (amount > 0) {
              amount = amount ~/ 10;
            }
          } else {
            if (amount.toString().length < 18) {
              amount = int.parse(amount.toString() + value);
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF393E46),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
