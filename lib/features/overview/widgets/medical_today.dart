import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';

class MedicalTodayItem extends StatelessWidget {
  final String image;
  final String patientName;
  final String doctorName;
  final DateTime time;
  final int status;
  const MedicalTodayItem({
    Key? key,
    required this.image,
    required this.patientName,
    required this.doctorName,
    required this.time,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.3),
                  blurRadius: 3,
                ),
              ],
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
                Text(
                  doctorName,
                  style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.primarySecondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                Text(
                  DateFormat().add_jm().format(time),
                  style: const TextStyle(
                      color: Colors.grey,
                      // fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ],
            ),
          ),
          const SizedBox(width: 3),
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (status == 0) ? Colors.red : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
