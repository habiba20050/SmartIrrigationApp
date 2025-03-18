import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = true; // Default state for switch
  bool isDarkMode = false; // Toggle theme (simulated)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Title color changed to white
        ),
        backgroundColor: const Color(0xFF1B401D), // Primary color
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF2F2F2), // Background color
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1B401D), // Title changed to white
                  ),
                ),
                const SizedBox(height: 20),

                // 🔹 Language Setting
                _buildSettingCard(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'English (Default)',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Language selection coming soon!')),
                    );
                  },
                ),

                // 🔹 Notifications
                _buildSettingCard(
                  icon: Icons.notifications_active,
                  title: 'Notifications',
                  subtitle: notificationsEnabled ? 'Enabled' : 'Disabled',
                  trailing: Switch(
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                    activeColor: const Color(0xFF1B401D), // Primary color
                  ),
                ),

                // 🔹 Theme Selection (Light/Dark)
                _buildSettingCard(
                  icon: Icons.palette,
                  title: 'Appearance',
                  subtitle: isDarkMode ? 'Dark Mode' : 'Light Mode',
                  trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                    activeColor: const Color(0xFF1B401D), // Primary color
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),

          // Background Image
          Positioned(
            bottom: 5,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/golden-glow.png',
                width: 400,
                height: 350,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to create stylish setting cards
  Widget _buildSettingCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      color: const Color(0xFFF2F2F2), // Background color
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF255929), size: 30), // Secondary color
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF010D03)), // Darkest shade
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFF255929))), // Secondary color
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, color: Color(0xFF1B401D)), // Primary color
        onTap: onTap,
      ),
    );
  }
}
