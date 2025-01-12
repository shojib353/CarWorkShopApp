import 'package:car_workshop_mobile_app/presentation/screens/booking_screen.dart';
import 'package:car_workshop_mobile_app/presentation/screens/drawer.dart';
import 'package:car_workshop_mobile_app/presentation/widgets/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/calender_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.email});
  final String email;

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {
  final db = FirebaseFirestore.instance;
  bool _isBookingScreen = false;
  int _selectedIndex = 0;
  String? userName;
  String? role;

  Future<String?> getUser() async {
    try {
      final snapshot = await db.collection('users').doc(widget.email).get();
      final data = snapshot.data() as Map<String, dynamic>;
      setState(() {
        userName = data['name'];
        role = data['role'];
      });
    } catch (e) {
      return 'Error fetching user';
    }
    return null;
  }

  void _onItemTapped(int index) {
    _isBookingScreen = false;
    _selectedIndex = index;
    setState(() {});
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
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
          (role == 'Admin')
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isBookingScreen = true;
                    });
                  },
                  icon: const Icon(Icons.add))
              : Container(),
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
