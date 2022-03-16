import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    Key? key,
    required this.text,
    required this.hint,
    required this.prefixIcon,
  }) : super(key: key);

  final String text;
  final String hint;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 1,
          ),
        ),
        labelText: hint,
        prefixIcon: prefixIcon,
      ),
      readOnly: true,
      controller: TextEditingController()..text = text,
    );
  }
}
