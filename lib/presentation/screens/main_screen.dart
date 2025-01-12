import 'package:car_workshop_mobile_app/presentation/screens/booking_screen.dart';
import 'package:car_workshop_mobile_app/presentation/screens/home_screen.dart';
import 'package:car_workshop_mobile_app/presentation/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'calender_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.email, required this.id});
  final String email;
  final String id;

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {
  final db = FirebaseFirestore.instance;
  bool _isBookingScreen = false;
  int _selectedIndex = 0;
  String? userName;
  String? role;

  Future<void> getUser() async {
    try {
      final snapshot = await db.collection('users').doc(widget.id).get();
      final data = snapshot.data();
      if (data != null) {
        setState(() {
          userName = data['name'];
          role = data['role'];
        });
      }
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _isBookingScreen = false;
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    if (userName == null || role == null) {
      // Show a loading indicator while user data is being fetched
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Pages for bottom navigation
    final List<Widget> _pages = [
      HomeScreen(
        role: role!,
        onAddMechanicTap: () {
          setState(() {
            _isBookingScreen = true;
          });
        },
      ),
      CalenderScreen(
        userName: userName!,
        userRole: role!,
      ),
      const BookingScreen(),
    ];

    return Scaffold(
      drawer: AppDrawer(
        userName: userName,
        role: role,
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        actions: [
          if (role == 'Admin')
            IconButton(
              onPressed: () {
                setState(() {
                  _isBookingScreen = true;
                });
              },
              icon: const Icon(Icons.add),
            ),
        ],
        title: const Text(
          "Car Servicing App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
        fixedColor: Colors.cyan,
        onTap: _onItemTapped,
      ),
      body: _isBookingScreen ? const BookingScreen() : _pages[_selectedIndex],
    );
  }
}
