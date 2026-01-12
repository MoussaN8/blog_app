import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthButtonGradient extends StatelessWidget {
  final String textButton;
  final VoidCallback onpressed;
  const AuthButtonGradient({super.key, required this.textButton, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
  colors: [AppPallete.gradient1, AppPallete.gradient2],
  begin: Alignment.bottomCenter, // ✅ utiliser Alignment
  end: Alignment.topRight,
),

        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: const Size(390, 40),
        ),
        child: Text(
          textButton,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
    );
  }
}
