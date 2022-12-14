import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/custom_button.dart';

class ExaminationItem extends StatelessWidget {
  const ExaminationItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 200,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.only(right: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        // border: Border.all(width: 2, color: AppColors.primaryColor),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/pdf.png',
                height: 50.0,
                width: 50.0,
              ),
              const Spacer(),
              Container(
                height: 10.0,
                width: 10.0,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            'Exmaination Id 1',
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Text(
            DateFormat().add_yMMMEd().format(DateTime.now()),
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 30.0,
            width: double.infinity,
            child: CustomButton(
              onTap: () {},
              text: "Check",
            ),
          ),
        ],
      ),
    );
  }
}
