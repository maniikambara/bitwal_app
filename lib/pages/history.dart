import 'package:bitwal_app/pages/more.dart';
import 'package:bitwal_app/widgets/filtertoken.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({ super.key });

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String selectedMonth = 'Januari';

  final List<String> months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  int getDaysInMonth(String month) {
  switch (month) {
    case 'Januari':
    case 'Maret':
    case 'Mei':
    case 'Juli':
    case 'Agustus':
    case 'Oktober':
    case 'Desember':
      return 31;
    case 'April':
    case 'Juni':
    case 'September':
    case 'November':
      return 30;
    case 'Februari':
      return 28; // Tidak menangani tahun kabisat untuk kesederhanaan
    default:
      return 30;
  }
}

String getTransactionDate(int groupIndex) {
  final daysInMonth = getDaysInMonth(selectedMonth);
  int day = (groupIndex % daysInMonth) + 1; // Hari bertambah sesuai grup transaksi
  return '$day $selectedMonth 2024';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
        backgroundColor: const Color(0xFF393E46),
        elevation: 0,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Image.asset('lib/images/more.png', width: 40, height: 40),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => More()),
          ),
        ),
        centerTitle: true,
        title: Image.asset(
          'lib/images/LogoText.png',
          width: 100,
          height: 40,
        ),
        actions: [
          IconButton(
            icon: Image.asset('lib/images/notif.png', width: 40, height: 40),
            onPressed: () {
              // Aksi untuk Notifikasi
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.filter_list, color: Colors.white, size: 40),
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    backgroundColor: const Color(0xFF222831),
                    builder: (_) => const TokenFilterSheet(),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'H I S T O R Y',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Scrollable Month Selection Tabs
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 8),
            child: SizedBox(
              height: 40,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: months.map((month) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMonth = month;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: month == selectedMonth
                              ? const Color(0xFFD9D9D9)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          month,
                          style: TextStyle(
                            color: month == selectedMonth
                                ? Colors.black
                                : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const Divider(color: Colors.white, thickness: 1),
          const SizedBox(height: 10),
          // History Items
          Expanded(
  child: ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: 10 + (10 ~/ 3), // Total transaksi + tanggal
    itemBuilder: (context, index) {
      final actualIndex = index - (index ~/ 4);

      // Tampilkan tanggal setiap 3 transaksi
      if (index % 4 == 0) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            getTransactionDate(index ~/ 4),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        return buildTransactionCard(actualIndex);
      }
    },
  ),
),
        ],
      ),
    );
  }

  Widget buildTransactionCard(int index) {
    List<String> statuses = ['Berhasil', 'Gagal', 'Sedang Proses'];
    String status = statuses[index % 3];
    Color statusColor = getStatusColor(status);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          const CircleAvatar(
            radius: 32,
            backgroundColor: Color(0xFF222831),
            child: Icon(Icons.swap_horiz, color: Colors.white),
          ),
          const SizedBox(width: 10),
          // Transaction Details
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transfer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'BTCoin\nL2Hb6obic...X7ewJ8x',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Transaction Info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                '-0.0001 BTC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '-Rp. 146,281',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Berhasil':
        return Colors.green;
      case 'Gagal':
        return Colors.red;
      case 'Sedang Proses':
        return Colors.yellow;
      default:
        return Colors.white;
    }
  }
}
