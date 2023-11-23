import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'THIS IS ME!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/RADEN-930.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Muhammad Alfito Priananda',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color.fromARGB(255, 0, 0, 0)),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: FaIcon(FontAwesomeIcons.github),
                  // icon: FaIcon(FontAwesomeIcons.github),
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(74),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    ),
                  ),
                  label: Text(
                    "GitHub",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
