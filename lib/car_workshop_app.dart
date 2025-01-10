import 'package:car_workshop_mobile_app/presentation/screens/car_workshop_home_screen.dart';
import 'package:flutter/material.dart';

class CarWorkshopApp extends StatelessWidget {
  const CarWorkshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CarWorkshopHomeScreen(),
    ) ;
  }
}

