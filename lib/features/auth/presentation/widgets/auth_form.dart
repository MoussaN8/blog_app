import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool hiddenPassword;
  const AuthForm({
    super.key,
    required this.hintText,
    required this.controller,
    this.hiddenPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return "$hintText est requis ! ";
        } else {
          return null;
        }
      },
      obscureText: hiddenPassword,
    );
  }
}
