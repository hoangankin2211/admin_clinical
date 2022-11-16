import 'package:flutter/material.dart';

class InformationItem extends StatelessWidget {
  final String mainTitle;
  final Widget title;
  const InformationItem({
    Key? key,
    required this.mainTitle,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            mainTitle,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(flex: 5, child: title),
      ],
    );
  }
}
