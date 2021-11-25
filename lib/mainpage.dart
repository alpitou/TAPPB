import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:f1_pedia/driverlist.dart';
import 'package:f1_pedia/main.dart';
import 'package:f1_pedia/profil.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; //default index

  List<Widget> _widgetOptions = [
    HomeScreen(),
    DriverList(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: Color(0xff180c20),
        unSelectedColor: Colors.white,
        backgroundColor: Color(0xffe30404),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Top,
        // gradient: LinearGradient(
        //   colors: [Colors.pink, Colors.yellow],
        // ),
        customBottomBarItems: [
          CustomBottomBarItems(label: 'Circuits', icon: Icons.edit_road),
          CustomBottomBarItems(
            label: 'Drivers',
            icon: Icons.settings_input_svideo,
          ),
          CustomBottomBarItems(
            label: 'Account',
            icon: Icons.account_box_outlined,
          ),
        ],
      ),
    );
  }
}
