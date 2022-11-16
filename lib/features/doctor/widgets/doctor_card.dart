import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/doctor.dart';

class DoctorCard1 extends StatelessWidget {
  final Doctor doctor;
  const DoctorCard1({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.headline1TextColor.withOpacity(0.2),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(doctor.avt!),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Dr ${doctor.name!}',
                        style: const TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Divider(
                    thickness: 0.3, color: AppColors.headline1TextColor),
                const SizedBox(height: 2),
                Text(
                  doctor.type!,
                  style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                Text(
                  doctor.address!,
                  style: const TextStyle(
                      color: AppColors.headline1TextColor, fontSize: 12),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
