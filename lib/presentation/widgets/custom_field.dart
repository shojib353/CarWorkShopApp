import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;

  const CustomField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<CustomField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
        label: Text(widget.label),
        hintStyle: const TextStyle(color: Colors.black),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required Field';
        }
        return null;
      },
      style: const TextStyle(
        color: Colors.black,
      ),
    );
  }
}
