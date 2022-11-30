import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  final String mainTitle;
  final DateTime time;
  final int type;
  const NotificationItem({
    Key? key,
    required this.mainTitle,
    required this.time,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Container(
            width: 45.0,
            height: 45.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3), blurRadius: 5.0),
              ],
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/icons/app_icon.png'),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mainTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 3.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.timelapse_rounded,
                        color: Colors.blue, size: 16.0),
                    Text(
                      DateFormat().add_yMMMEd().format(DateTime.now()),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ]),
        const SizedBox(height: 3.0),
        const Divider(thickness: 1),
      ],
    );
  }
}
