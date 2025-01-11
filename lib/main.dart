import 'package:car_workshop_mobile_app/car_serving_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures everything is initialized properly
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  runApp(const CarServingApp());
}




//import 'package:flutter/foundation.dart';
//  if (Firebase.apps.isEmpty) {
//   if (kIsWeb) {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } else {
//     await Firebase.initializeApp(
//       name: 'car_workshop_mobile_app',
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   }
// }

