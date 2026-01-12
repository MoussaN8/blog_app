import 'package:flutter/material.dart';

class BlogForm extends StatelessWidget {
  final String titre;
  final TextEditingController controller;
  const BlogForm({super.key, required this.titre, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: titre,
          border: OutlineInputBorder(),
        ),
        maxLines: null,
        validator: (value) {
          if (value!.isEmpty) {
            return "veuillez remplir $titre ";
          }
          return null;
        },
      ),
    );
  }
}
