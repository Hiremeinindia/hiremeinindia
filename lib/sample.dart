import 'package:flutter/material.dart';

class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  State<Sample> createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            // Toggle the expanded state on button click
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text('Toggle Container'),
        ),
        SizedBox(height: 20),

        // AnimatedContainer that expands or collapses based on isExpanded
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: 200,
          height: isExpanded ? 200 : 50,
          color: Colors.blue,
          child: Center(
            child: Text(
              'Expanded Container',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
