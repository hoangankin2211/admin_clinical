import 'package:flutter/material.dart';

class HeaderListItem extends StatelessWidget {
  final List<String> titles;
  const HeaderListItem({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.blue,
      ),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          ...titles.map(
            (e) => Expanded(
              child: Text(
                e,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
