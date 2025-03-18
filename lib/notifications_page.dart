import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [
    {
      'icon': Icons.warning_amber_rounded,
      'title': 'Low Water Level',
      'subtitle': 'Detected at 10:30 AM',
      'color': const Color(0xFF010D03), // Darkest shade
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Fertilizer Applied',
      'subtitle': 'Completed at 9:15 AM',
      'color': const Color(0xFF1B401D), // Primary color
    },
    {
      'icon': Icons.water_drop,
      'title': 'Irrigation System Activated',
      'subtitle': 'Started at 8:45 AM',
      'color': const Color(0xFF255929), // Secondary color
    },
    {
      'icon': Icons.lightbulb,
      'title': 'Optimal Soil Moisture Achieved',
      'subtitle': 'Checked at 7:30 AM',
      'color': const Color(0xFF0C260E), // Accent color
    },
  ];

  void _addNotification() {
    setState(() {
      notifications.insert(0, {
        'icon': Icons.notifications_active,
        'title': 'New Sensor Alert',
        'subtitle': 'Received at ${DateTime.now().hour}:${DateTime.now().minute}',
        'color': const Color(0xFF1B401D),
      });
    });
  }

  void _removeNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
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
            color: const Color(0xFFF2F2F2), // Background color
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Notifications',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF255929)),
                  ),
                  const SizedBox(height: 15),

                  // 🔹 Notifications List
                  Expanded(
                    child: notifications.isEmpty
                        ? const Center(child: Text("No new notifications.", style: TextStyle(fontSize: 18, color: Colors.black54)))
                        : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) => _removeNotification(index),
                          background: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.centerRight,
                            color: Colors.red,
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: _buildNotificationCard(
                            icon: notification['icon'],
                            title: notification['title'],
                            subtitle: notification['subtitle'],
                            color: notification['color'],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Positioned Image at the Bottom Right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2, right: 2),
              child: Image.asset(
                'assets/images/flowers-.png',
                width: 250, // Adjusted for better layout
                height: 250,
              ),
            ),
          ),
        ],
      ),

      // Floating Button to Simulate New Notification
      floatingActionButton: FloatingActionButton(
        onPressed: _addNotification,
        backgroundColor: const Color(0xFF1B401D),
        child: const Icon(Icons.add_alert, color: Colors.white),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color.withOpacity(0.2), child: Icon(icon, color: color)),
        title: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
      ),
    );
  }
}
