import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String? email;
  final String? end;
  final String? make;
  final String? mechanic;
  final String? model;
  final String? name;
  final String? phone;
  final String? plate;
  final String? start;
  final String? title;
  final String? year;

  BookingModel({
    this.email,
    this.end,
    this.make,
    this.mechanic,
    this.model,
    this.name,
    this.phone,
    this.plate,
    this.start,
    this.title,
    this.year,
  });

  factory BookingModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return BookingModel(
      email: data?['email'],
      end: data?['end'],
      make: data?['make'],
      mechanic: data?['mechanic'],
      model: data?['model'],
      name: data?['name'],
      phone: data?['phone'],
      plate: data?['plate'],
      start: data?['start'],
      title: data?['title'],
      year: data?['year'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (email != null) "email": email,
      if (end != null) "end": end,
      if (make != null) "make": make,
      if (mechanic != null) "mechanic": mechanic,
      if (model != null) "model": model,
      if (name != null) "name": name,
      if (phone != null) "phone": phone,
      if (plate != null) "plate": plate,
      if (start != null) "start": start,
      if (title != null) "title": title,
      if (year != null) "year": year,
    };
  }
}
