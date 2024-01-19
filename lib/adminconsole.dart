import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole();

  @override
  State<AdminConsole> createState() => _AdminDashboard();
}

class _AdminDashboard extends State<AdminConsole> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    initializeLocalNotifications();
    selectedValue = items.first; // Set the initial value
  }

  bool isChecked = false;
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(
            'app_icon'); // Replace 'app_icon' with your app's launcher icon
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id', // Replace 'your_channel_id' with your desired channel ID
      'Your channel name',

      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Cash Received and Verified',
      'The cash payment has been received and verified!!!',
      platformChannelSpecifics,
    );
  }

  Future<void> sendCashNotification() async {
    final String serverUrl = 'http://localhost:3009';
    final String endpoint = '/cashNotification';

    try {
      final response = await http.post(
        Uri.parse('$serverUrl$endpoint'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Display a popup message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Cash Received and Verified'),
              content:
                  Text('The cash payment has been received and verified!!!.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    showNotification(); // Show the notification
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print(
          'Failed to send notification. Status code: ${response.statusCode}',
        );
      }
    } catch (error) {
      print('Error sending notification: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // ... (existing app bar configuration)
          ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Simulate the cash notification by calling the method
                sendCashNotification();
              },
              child: Text('Simulate Cash Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
