import 'package:flutter/material.dart';
import 'package:hiremeinindiaapp/widgets/custombutton.dart';

class Sample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Drawer Example'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Add your onTap logic here
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Add your onTap logic here
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        7), // Adjust border radius as needed
                  ),
                ),
                onPressed: () {},
                child: ImageIcon(
                  NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/filter.png?alt=media&token=fb12f309-716f-4b68-94b0-2c551dd998b5',
                  ),
                  size: 25,
                  color: Colors.indigo.shade900,
                ),
              ),
              CustomRectButton(
                  topright: Radius.circular(5),
                  bottomright: Radius.circular(5),
                  onPressed: () {},
                  image: ImageIcon(
                    NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/hiremeinindia-14695.appspot.com/o/table.png?alt=media&token=75eaa626-2b1f-4faf-8ce5-73480c3141df',
                    ),
                    size: 25,
                    color: Colors.indigo.shade900,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
