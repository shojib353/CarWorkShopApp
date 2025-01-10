import 'package:flutter/material.dart';

class WeatherCard extends StatelessWidget {
  final String time;
  final String temp;
  final String iconUrl;

  WeatherCard({required this.time, required this.temp, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 100, // Card width
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 5),
          Image.network(
            iconUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(
            '$temp°',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
