import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MainPageState();
}

class _MainPageState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 60,),
            OutlinedButton.icon(
              onPressed: () {},
              label: Text("Add Mechanic"),
              icon: Icon(Icons.miscellaneous_services),
            ),
          ],
        ),
      ),
    );
  }
}