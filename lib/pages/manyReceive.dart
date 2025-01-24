import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/widgets/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManyReceive extends StatefulWidget {
  const ManyReceive({super.key});

  @override
  _ManyReceiveState createState() => _ManyReceiveState();
}

class _ManyReceiveState extends State<ManyReceive> {
  List<bool> isChecked = [];
  List<Map<String, dynamic>> users = []; // To store the list of users
  List<Map<String, dynamic>> filteredUsers = []; // To store filtered users
  String searchQuery = ''; // Search query for filtering
  bool isLoading = true; // Loading state for Firestore data

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Fetch users when the page is initialized
  }

  // Fetch list of users from Firestore
  Future<void> _fetchUsers() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('users').get();
      final usersData = snapshot.docs
          .map((doc) {
        return {
          'uid': doc.id,
          'username': doc['username'] ?? 'Unknown', // Only fetch the username
          'avatar': 'lib/images/Logo.png', // Default avatar
        };
      }).toList();

      setState(() {
        users = usersData;
        filteredUsers = usersData; // Initially, no filtering, show all users
        isChecked = List.generate(usersData.length, (_) => false); // Initialize checkbox state
        isLoading = false; // Set loading state to false after fetching
      });
    } catch (e) {
      print("Error fetching users: $e");
      setState(() {
        isLoading = false; // Stop loading if an error occurs
      });
    }
  }

  // Filter users based on the search query
  void _filterUsers(String query) {
    setState(() {
      searchQuery = query;
      filteredUsers = users.where((user) {
        return user['username']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  // Check if at least 2 users are selected
  bool get isEnoughSelected => isChecked.where((element) => element).length >= 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Search TextField
            TextField(
              onChanged: _filterUsers, // Call filter function on change
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
            ),
            const SizedBox(height: 20),
            // Select Many Receive container
            Container(
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
            ),
            const SizedBox(height: 20),
            // Display loading state or user list
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            // Display the avatar or placeholder image
                            CircleAvatar(
                              backgroundImage: AssetImage(filteredUsers[index]['avatar']),
                              radius: 25,
                            ),
                            const SizedBox(width: 15),
                            Text(
                              filteredUsers[index]['username'],
                              style: const TextStyle(color: Colors.white, fontSize: 16),
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
                    ),
                  ),
            const SizedBox(height: 20),
            // Confirm button
            ElevatedButton(
              onPressed: isEnoughSelected
                  ? () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPage(
                            type: '', token: '', amount: 0, currency: '', price: 0, recipientId: '', memo: '', timestamp: DateTime.now(),
                          ),
                        ),
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
