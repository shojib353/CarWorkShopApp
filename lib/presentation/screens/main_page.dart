import 'package:car_workshop_mobile_app/presentation/screens/drawer.dart';
import 'package:car_workshop_mobile_app/presentation/widgets/home_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/calender_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages=[
    HomeScreen(),
    CalenderScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Car Servicing App",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "Calender",
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.cyanAccent,
        onTap: _onItemTapped,
      ),
      body: _pages[_selectedIndex],
    );
  }
}