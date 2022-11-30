import 'package:flutter/material.dart';

class SettingPopupItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() press;
  final int type;
  const SettingPopupItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: type == 0 ? Colors.blue[100] : Colors.red[100],
              ),
              child: Icon(
                icon,
                color: type == 0 ? Colors.blue : Colors.red,
                size: 15.0,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        const Divider(thickness: 1),
      ],
    );
  }
}
