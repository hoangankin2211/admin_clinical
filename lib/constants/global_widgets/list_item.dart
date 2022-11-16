import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final List<Widget> widgets;
  const ListItem({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Row(
        children: [
          ...widgets.map((e) => Expanded(child: e)),
        ],
      ),
    );
  }
}
