import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../model/booking_model.dart';
import '../../model/meeting.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen(
      {super.key, required this.userName, required this.userRole});

  final String userName;
  final String userRole;

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  final db = FirebaseFirestore.instance;
  List<BookingModel> bookingData = [];

  @override
  void initState() {
    super.initState();
    fetchBookingData();
  }

  Future<void> fetchBookingData() async {
    final snapshot = await db
        .collection("booking")
        .where('mechanic', isEqualTo: widget.userName)
        .withConverter(
          fromFirestore: BookingModel.fromFirestore,
          toFirestore: (BookingModel booking, _) => booking.toFirestore(),
        )
        .get();

    setState(() {
      bookingData = snapshot.docs.map((doc) => doc.data()).toList();
      print(bookingData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.userRole == 'Mechanic')
        ? SfCalendar(
            view: CalendarView.month,
            dataSource: MeetingDataSource(_getDataSource()),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode:
                    MonthAppointmentDisplayMode.appointment),
          )
        : Center(
            child: Container(
              child: const Text(
                'You have no permission to see that',
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];

    for (var i = 0; i < bookingData.length; i++) {
      final DateTime startingTime = DateTime.parse(bookingData[i].start!);
      final DateTime startTime =
          DateTime(startingTime.year, startingTime.month, startingTime.day, 9);

      final DateTime endingTime = DateTime.parse(bookingData[i].end!);
      final DateTime endTime =
          DateTime(endingTime.year, endingTime.month, endingTime.day, 9);

      meetings.add(Meeting(bookingData[i].title!, startTime, endTime,
          const Color(0xFF0F8644), false));
    }
    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
