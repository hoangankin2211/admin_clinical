import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';

class RowExaminationItem extends StatelessWidget {
  final String examId;
  final String patientName;
  final DateTime time;
  const RowExaminationItem({
    Key? key,
    required this.examId,
    required this.patientName,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10.0),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.cover,
            'assets/images/pdf.png',
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              examId,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              patientName,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              DateFormat().add_yMEd().format(DateTime.now()),
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.more_horiz,
                color: AppColors.headline1TextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
