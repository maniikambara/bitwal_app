import 'package:bitwal_app/pages/more.dart';
import 'package:bitwal_app/widgets/securitydetail.dart';
import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF393E46),
      appBar: _buildAppBar(context),
      body: _buildBody(context),
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
          onPressed: () {
            // Notification action
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    final securityOptions = [
      'Two-Factor Authentication (2FA)',
      'Password Management',
      'Personal Data Management',
      'Transaction Privacy',
      'Access the app',
      'Transaction Security',
      'Security Education',
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: securityOptions.length,
      itemBuilder: (context, index) {
        return _buildSecurityOption(
          context,
          title: securityOptions[index],
          onTap: () => _navigateToSecurityDetail(context, securityOptions[index]),
        );
      },
      separatorBuilder: (context, index) => const Divider(color: Colors.white54),
    );
  }

  Widget _buildSecurityOption(BuildContext context, {required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: onTap,
    );
  }

  void _navigateToSecurityDetail(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSecuritySettingsPage(title: title),
      ),
    );
  }
}
