import 'package:car_workshop_mobile_app/model/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.onAddMechanicTap, required this.role});

  final void Function() onAddMechanicTap;
  final String role;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = FirebaseFirestore.instance;
  late int listCount;
  List<BookingModel> bookings = [];

  @override
  void initState() {
    super.initState();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    final snapshot = await db
        .collection("booking")
        .withConverter(
          fromFirestore: BookingModel.fromFirestore,
          toFirestore: (BookingModel booking, _) => booking.toFirestore(),
        )
        .get();

    setState(() {
      bookings = snapshot.docs.map((doc) => doc.data()).toList();
      print(bookings);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: bookings.isEmpty
            ? const CircularProgressIndicator()
            : ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text('${index + 1}'),
                    title: Expanded(
                      child: Text(bookings[index].name!),
                    ),
                    subtitle: Expanded(
                      child: Text(bookings[index].mechanic!),
                    ),
                  );
                }),
      ),
    );
  }
}
