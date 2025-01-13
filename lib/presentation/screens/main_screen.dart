import 'package:car_workshop_mobile_app/presentation/screens/booking_screen.dart';
import 'package:car_workshop_mobile_app/presentation/screens/home_screen.dart';
import 'package:car_workshop_mobile_app/presentation/widgets/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.email, required this.id});
  final String email;
  final String id;

  @override
  State<MainPage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MainPage> {
  final db = FirebaseFirestore.instance;

  String? userName;
  String? role;
  bool? isAdmin;

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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(
                        userName: userName!,
                        userRole: role!,
                      ),
                    ),
                  );
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
      body: HomeScreen(
        userRole: role!,
        userName: userName!,
      ),
    );
  }
}
