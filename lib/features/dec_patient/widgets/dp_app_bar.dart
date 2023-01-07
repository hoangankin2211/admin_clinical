import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../routes/name_route.dart';
import '../../auth/widgets/custom_button.dart';

class DpApBar extends StatelessWidget {
  final Function(int) switchPage;
  final Function() nexxPageCallback;
  final Function() backPageCallback;
  final Function() openHealthRecordViewCallback;
  final Function() openFindIDViewCallback;
  const DpApBar(
      {super.key,
      required this.switchPage,
      required this.nexxPageCallback,
      required this.openHealthRecordViewCallback,
      required this.backPageCallback,
      required this.openFindIDViewCallback});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/doctor1.png',
              fit: BoxFit.cover,
              height: 50.0,
              width: 50.0,
            ),
            const Text(
              ' Clinical App',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ],
        ),
        const Spacer(),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: backPageCallback,
                child: const Text(
                  'Home',
                  style: TextStyle(
                    color: Color.fromARGB(255, 53, 72, 78),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(width: 90),
              InkWell(
                onTap: openHealthRecordViewCallback,
                child: const Text(
                  'View Health Record',
                  style: TextStyle(
                    color: Color.fromARGB(255, 53, 72, 78),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(width: 90),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Find a Doctor',
                  style: TextStyle(
                    color: Color.fromARGB(255, 53, 72, 78),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(width: 90),
              InkWell(
                onTap: openFindIDViewCallback,
                child: const Text(
                  'Find Your ID',
                  style: TextStyle(
                    color: Color.fromARGB(255, 53, 72, 78),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              const SizedBox(width: 70),
              SizedBox(
                width: 250.0,
                height: 50,
                child: CustomButton1(
                  title: "Book now",
                  onPressed: nexxPageCallback,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
