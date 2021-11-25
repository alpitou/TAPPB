import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'F1Pedia',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 300,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/1.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Alif Nabil Musyaffa',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 4,
            ),
            Text('21120119130078'),
          ],
        ),
      ),
    );
  }
}
