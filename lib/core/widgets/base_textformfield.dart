import 'package:flutter/material.dart';

class BaseTextFormField extends StatelessWidget {
  const BaseTextFormField({
    Key? key,
    required this.hint,
    this.controller,
    required this.textInputAction,
    required this.textInputType,
    required this.prefixIcon,
    required this.fun,
    this.onTap,
    this.isPassword = false,
    this.isReadOnly = false,
  }) : super(key: key);

  final String hint;
  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Widget prefixIcon;
  final String? Function(String?)? fun;
  final bool isPassword;
  final bool isReadOnly;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        labelText: hint,
        prefixIcon: prefixIcon,
      ),
      validator: fun,
      obscureText: isPassword,
      readOnly: isReadOnly,
      onTap: onTap,
    );
  }
}
