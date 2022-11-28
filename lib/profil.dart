import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              height: 200,
            ),
            Text(
              'F1 GEEK',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFFFFFF)),
            ),
            SizedBox(
              height: 50,
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/1.jpg'),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Daniel Andhika Yudistya',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xffFFFFFF)),
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
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
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
