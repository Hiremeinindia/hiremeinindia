import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sample extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  void sendMessage(String message) {
    FirebaseFirestore.instance.collection('messages').add({
      'sender': 'user',
      'message': message,
      'timestamp': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Sender App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Enter Message'),
              ),
              ElevatedButton(
                onPressed: () {
                  sendMessage(_controller.text);
                },
                child: Text('Send Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
