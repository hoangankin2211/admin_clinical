import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';

class MedicalOfDoctorToday extends StatelessWidget {
  final String image;
  final String patientName;
  final String doctorName;
  final DateTime time;
  final int status;
  const MedicalOfDoctorToday({
    Key? key,
    required this.image,
    required this.patientName,
    required this.doctorName,
    required this.time,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color.fromARGB(255, 198, 229, 255),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.3),
                  blurRadius: 3,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor[300]!,
                  Colors.deepPurple[400]!,
                ],
              ),
            ),
            child: Center(
              child: Text(
                patientName[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
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
                      fontSize: 18.0),
                ),
                Text(
                  '${DateFormat().add_yMEd().format(time)} | ${DateFormat().add_jm().format(time)}',
                  style: const TextStyle(
                      color: Colors.grey,
                      // fontWeight: FontWeight.bold,
                      fontSize: 16.0),
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
