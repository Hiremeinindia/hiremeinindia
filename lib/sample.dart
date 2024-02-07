import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DownloadButton extends StatefulWidget {
  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _downloading = false;
  String _downloadMessage = '';

  Future<void> _downloadImage() async {
    setState(() {
      _downloading = true;
      _downloadMessage = 'Downloading image...';
    });

    // Retrieve the image from Firestore
    final String imageUrl =
        'YOUR_IMAGE_URL_HERE'; // Replace with your Firestore image URL
    final firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref(imageUrl);

    try {
      // Download the image to temporary directory
      final Directory tempDir = await getTemporaryDirectory();
      final File file = File('${tempDir.path}/image.jpg');

      await ref.writeToFile(file);

      setState(() {
        _downloadMessage = 'Image downloaded successfully!';
      });
    } catch (e) {
      print('Error downloading image: $e');
      setState(() {
        _downloadMessage = 'Error downloading image';
      });
    } finally {
      setState(() {
        _downloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _downloading ? null : _downloadImage,
              child: Text('Download Image'),
            ),
            SizedBox(height: 20.0),
            Text(_downloadMessage),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DownloadButton(),
  ));
}
