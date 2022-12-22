import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';

class PatientInMonthRow extends StatelessWidget {
  final String name;
  final String time;
  final int groupValue;
  final Function(int?) func;
  final Function() press;
  final String? thumb;
  PatientInMonthRow({
    super.key,
    required this.name,
    required this.time,
    required this.groupValue,
    required this.func,
    required this.press,
    required this.thumb,
  });
  RxBool onIt = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: press,
        onHover: ((value) => onIt.value = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: onIt.value ? AppColors.primaryColor[300] : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  color: onIt.value ? Colors.black12 : Colors.white,
                  blurRadius: 10.0),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: onIt.value ? 35.0 : 30.0,
                width: onIt.value ? 35.0 : 30.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(thumb == ''
                          ? 'https://thumbs.dreamstime.com/b/medical-form-list-results-data-approved-check-mark-vector-flat-cartoon-clinical-checklist-document-checkbox-133036988.jpg'
                          : thumb!)),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 3.0),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Text(
                  name,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: onIt.value
                        ? Colors.white
                        : AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: onIt.value ? 20.0 : 16.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  time,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: onIt.value
                        ? Colors.white
                        : AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: onIt.value ? 20.0 : 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
