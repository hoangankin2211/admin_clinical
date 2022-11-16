import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';

class MedicalExmaminationItem extends StatelessWidget {
  final String id;
  final DateTime date;
  final String clinicRoom;
  final String patientName;
  final int status;
  const MedicalExmaminationItem({
    Key? key,
    required this.id,
    required this.date,
    required this.clinicRoom,
    required this.patientName,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: AppColors.headline1TextColor.withOpacity(0.1),
              blurRadius: 10.0),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              id,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              DateFormat().add_yMd().format(date),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              clinicRoom,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              patientName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: status == 1
                        ? Colors.green.withOpacity(0.2)
                        : Colors.red.withOpacity(0.2),
                  ),
                  child: Text(status == 1 ? 'Completed' : 'Uncompleted',
                      style: TextStyle(
                        color: status == 1 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
