import 'package:flutter/material.dart';
import 'package:cgpa_application/presentation/result_screen/ResultPage.dart';
import 'package:cgpa_application/presentation/cgpa_screen/cgpa_screen.dart';
import 'package:cgpa_application/presentation/home_screen/HomePage.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _currentIndex = 0;

  late List<Widget Function()> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      () => HomePage(),
      () => CGPACalculate(0), // Pass the number of semesters or any required data
      () => ResultPage(score: 4.0), // Pass the CGPA or any required data
      // () => Profile(), // Uncomment and provide necessary data for Profile
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex](),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            label: 'CGPA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Result',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person),
          //   label: 'Profile',
          // ),
        ],
      ),
    );
  }
}
