import 'package:bitwal_app/pages/notif.dart';
import 'package:bitwal_app/widgets/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OneReceive extends StatefulWidget {
  const OneReceive({super.key});

  @override
  _OneReceiveState createState() => _OneReceiveState();
}

class _OneReceiveState extends State<OneReceive> {
  int? selectedIndex;
  List<Map<String, dynamic>> users = []; // List to store all users data
  List<Map<String, dynamic>> filteredUsers = []; // List to store filtered users based on search
  String searchQuery = ''; // Search query for filtering
  String currentUserUid = ''; // Store current user UID
  bool isLoading = true; // Loading state for Firestore data

  @override
  void initState() {
    super.initState();
    _getCurrentUser(); // Fetch the logged-in user's UID
  }

  // Fetch the current logged-in user's UID
  Future<void> _getCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserUid = user.uid; // Set the UID of the logged-in user
      });
      _fetchUsers(); // Fetch users after getting the current user's UID
    }
  }

  // Fetch list of users from Firestore, excluding the current user
  Future<void> _fetchUsers() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('users').get();
      final usersData = snapshot.docs
          .where((doc) => doc.id != currentUserUid) // Exclude the logged-in user
          .map((doc) {
        return {
          'uid': doc.id,
          'username': doc['username'] ?? 'Unknown', // Only fetch the username
        };
      }).toList();

      setState(() {
        users = usersData;
        filteredUsers = usersData; // Initially, no filtering, show all users
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
            const SizedBox(height: 40),
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
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF222831),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: const Text(
                "Select One Receiver",
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
                            const CircleAvatar(
                              backgroundImage: AssetImage('lib/images/Logo.png'), // Default avatar image
                              radius: 24,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              filteredUsers[index]['username'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Checkbox(
                              value: selectedIndex == index,
                              onChanged: (value) => setState(() => selectedIndex = value! ? index : null),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
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
              onPressed: selectedIndex != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPage(
                            type: '', token: '', amount: 0, currency: '', price: 0, recipientId: filteredUsers[selectedIndex!]['uid'], memo: '', timestamp: DateTime.now(),
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedIndex != null
                    ? const Color(0xFFD65A31)
                    : const Color(0xFF555555),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
              ),
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: selectedIndex != null ? Colors.white : const Color(0xFFAAAAAA),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
