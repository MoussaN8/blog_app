import 'dart:io';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Platform.isIOS ? 20 : 40,   // iOS plus petit
        height: Platform.isIOS ? 20 : 40,
        child: CircularProgressIndicator(
          strokeWidth: Platform.isIOS ? 2 : 4,  // iOS plus fin
          color: Platform.isIOS ? Colors.grey : Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}