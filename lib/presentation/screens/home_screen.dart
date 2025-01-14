import 'package:car_workshop_mobile_app/model/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'calender_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.userName,
    required this.userRole,
  });

  final String userRole;
  final String userName;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: bookings.isEmpty
              ? const CircularProgressIndicator()
              : (widget.userRole == 'Admin')
                  ? ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            elevation: 3,
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                CircleAvatar(
                                  radius: 25,
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(fontSize: 22),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        bookings[index].title!,
                                        style: const TextStyle(
                                          color: Colors.teal,
                                          // Color.fromARGB(255, 25, 25, 25),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Assigned Mechanic: ${bookings[index].mechanic!}',
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Start: ${bookings[index].start!}',
                                      ),
                                      const SizedBox(height: 3),
                                      Text('End: ${bookings[index].end!}'),
                                      const SizedBox(height: 3),
                                      Text('Plate: ${bookings[index].plate!}')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : CalenderScreen(
                      userName: widget.userName,
                      userRole: widget.userRole,
                    )),
    );
  }
}
