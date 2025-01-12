import 'package:car_workshop_mobile_app/presentation/widgets/custom_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<String> mechanicsName = [];
  String dropdownFirstValue = '';
  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMechanic();
  }

  Future<void> fetchMechanic() async {
    final snapshot =
        await db.collection('users').where('role', isEqualTo: 'Mechanic').get();
    setState(() {
      mechanicsName =
          snapshot.docs.map((element) => element['name'] as String).toList();
      if (mechanicsName.isNotEmpty) {
        dropdownFirstValue = mechanicsName[0];
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final makeController = TextEditingController();
  final modelController = TextEditingController();
  final yearController = TextEditingController();
  final plateController = TextEditingController();
  final titleController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'Full Name', controller: nameController),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'Phone', controller: phoneController),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'Email', controller: emailController),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Car Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'Make', controller: makeController),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'Model', controller: modelController),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'Year', controller: yearController),
                const SizedBox(
                  height: 10,
                ),
                CustomField(
                    label: 'Registration Plate', controller: plateController),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Booking Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'Title', controller: titleController),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'Start Date', controller: startController),
                const SizedBox(
                  height: 10,
                ),
                CustomField(label: 'End Date', controller: endController),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Assigning Mechanic',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton(
                      // Initial Value
                      value: dropdownFirstValue,

                      // Down Arrow Icon
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 27,
                      ),

                      // Array list of items
                      items: mechanicsName.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          mechanicsName = newValue! as List<String>;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Center(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Map<String, Object> bookingData = {
                              'name': nameController.text,
                              'phone': phoneController.text,
                              'email': emailController.text,
                              'make': makeController.text,
                              'model': modelController.text,
                              'year': yearController.text,
                              'plate': plateController.text,
                              'title': titleController.text,
                              'start': startController.text,
                              'end': endController.text,
                              'mechanic': mechanicsName,
                            };

                            await db
                                .collection('booking')
                                .add(bookingData)
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Booking Successful'),
                                ),
                              );
                            }, onError: (error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Booking Failed'),
                                ),
                              );
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Book Now',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
