import 'package:bitwal_app/pages/security.dart';
import 'package:bitwal_app/widgets/helps_feedback.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bitwal_app/services/auth_service.dart';
import 'package:bitwal_app/pages/login.dart';
import 'package:bitwal_app/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    try {
      await context.read<AuthService>().signOut();
      if (context.mounted) {
        // Show success dialog
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xFF393E46),
              title: const Text(
                'Success',
                style: TextStyle(color: Colors.white),
              ),
              content: const Text(
                'Logged out successfully',
                style: TextStyle(color: Colors.white70),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to login page and remove all previous routes
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Login()),
                      (route) => false,
                    );
                  },
                  child: const Text('OK', style: TextStyle(color: Colors.orange)),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
      stream: context.read<AuthService>().user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;
        if (user == null) {
          return const Center(child: Text('No user data available'));
        }

        return Scaffold(
          backgroundColor: const Color(0xFF222831),
          appBar: AppBar(
            backgroundColor: const Color(0xFF222831),
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Settings', style: TextStyle(color: Colors.white)),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage('lib/images/Logo.png'),
                          radius: 20,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My wallet",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              user.username,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Preferences'),
                    _buildSettingsTile(
                      context,
                      'Language',
                      'English',
                      () => _showOptionsDialog(context, 'Language', ['English', 'Indonesia (Coming Soon)']),
                    ),
                    _buildSettingsTile(
                      context,
                      'Currency',
                      'IDR',
                      () => _showOptionsDialog(context, 'Currency', ['IDR', 'USD (Coming Soon)']),
                    ),
                    _buildSettingsTile(context, 'Theme', 'System (Dark)', () {}),
                    _buildSettingsTile(
                      context,
                      'Reporting cycle',
                      'Local time',
                      () => _showOptionsDialog(context, 'Reporting cycle', ['Local time', 'UTC', 'GMT']),
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle('Study'),
                    _buildSettingsTile(
                      context,
                      'Academy',
                      '',
                      () => _launchURL('https://www.instagram.com/akademicryptocom'),
                    ),
                    _buildSettingsTile(
                      context,
                      'User Feedback',
                      '',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UserFeedbackPage()),
                        );
                      },
                    ),
                    _buildSettingsTile(
                      context,
                      'Security and Privacy',
                      '',
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SecurityPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Logout button at the bottom
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _handleLogout(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 14),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, String title, String subtitle, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: subtitle.isNotEmpty
              ? Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          onTap: onTap,
        ),
        const Divider(color: Colors.grey),
      ],
    );
  }

  void _showOptionsDialog(BuildContext context, String title, List<String> options) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF222831),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Divider(color: Colors.grey),
            ...options.map(
              (option) => ListTile(
                title: Text(
                  option,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () {
                  // Update selected option
                  Navigator.pop(context);
                },
              ),
            ),
            const Divider(color: Colors.grey),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[800],
                    ),
                    child: const Text('Confirm', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
