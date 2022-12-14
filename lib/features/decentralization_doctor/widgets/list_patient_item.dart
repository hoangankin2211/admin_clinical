import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class ListPatientItem extends StatelessWidget {
  final String image;
  final String name;
  final int time;
  final bool check;
  final Function() press;
  const ListPatientItem({
    Key? key,
    required this.image,
    required this.name,
    required this.time,
    required this.check,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: const EdgeInsets.all(15.0),
        margin: const EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: check
              ? const Color.fromARGB(255, 205, 233, 255)
              : Colors.transparent,
        ),
        child: Row(
          children: [
            Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 7.0)
                ],
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image == ''
                      ? 'https://thumbs.dreamstime.com/b/medical-form-list-results-data-approved-check-mark-vector-flat-cartoon-clinical-checklist-document-checkbox-133036988.jpg'
                      : image),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  const Text(
                    'Up Comming',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 170, 217, 255),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                '$time:00 AM',
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
