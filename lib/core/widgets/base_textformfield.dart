import 'package:flutter/material.dart';

class BaseTextFormField extends StatelessWidget {
  const BaseTextFormField({
    Key? key,
    required this.hint,
    required this.textInputAction,
    required this.textInputType,
    required this.prefixIcon,
    required this.fun,
    this.isPassword = false,
  }) : super(key: key);

  final String hint;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Widget prefixIcon;
  final String? Function(String?)? fun;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(
            width: 1,
            style: BorderStyle.none,
          ),
        ),
        hintText: hint,
        prefixIcon: prefixIcon,
      ),
      validator: fun,
      obscureText: isPassword,
    );
  }
}
