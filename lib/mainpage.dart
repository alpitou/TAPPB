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
        selectedColor: Color.fromARGB(255, 0, 0, 0),
        unSelectedColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 220, 23, 23),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Top,
        customBottomBarItems: [
          CustomBottomBarItems(label: 'Circuit', icon: Icons.edit_road),
          CustomBottomBarItems(
            label: 'Drivers',
            icon: Icons.settings_input_svideo,
          ),
          CustomBottomBarItems(
            label: 'MyProfile',
            icon: Icons.account_box_outlined,
          ),
        ],
      ),
    );
  }
}
