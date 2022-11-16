import 'package:flutter/material.dart';

class BtnWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback callBack;
  const BtnWithIcon({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            Text(
              " $title",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
