import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class Filtres extends StatefulWidget {
  final void Function(String) onSelected;
  const Filtres({super.key, required this.onSelected});

  @override
  State<Filtres> createState() => _FiltresState();
}

class _FiltresState extends State<Filtres> {
  final List<String> categories = const [
    'Economie',
    'Informatique',
    'Sport',
    'Santé',
    'Politique',
  ];

  String choice = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    choice = e;
                    setState(() {});
                    // on donnecle item choisi au parent

                    widget.onSelected(e);
                  },
                  child: Chip(
                    label: Text(e),
                    backgroundColor: choice == e ? AppPallete.gradient1 : null,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
