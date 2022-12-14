import 'package:admin_clinical/constants/global_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';

class PatientWaitItem extends StatelessWidget {
  final String headerTitle;
  final String id;
  final String title;
  final String time;
  final int index;
  final int groupValue;
  final bool check;
  final Function(int?) func;
  final Function() press;
  final String? thumb;
  PatientWaitItem(
      {super.key,
      required this.headerTitle,
      required this.id,
      required this.title,
      required this.time,
      required this.index,
      required this.groupValue,
      required this.func,
      required this.press,
      required this.check,
      required this.thumb,
      required this.examFunction});
  RxBool onIt = false.obs;
  final Function() examFunction;
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
            color: check
                ? AppColors.primaryColor[300]
                : onIt.value
                    ? AppColors.primaryColor[300]
                    : Colors.white,
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
                  headerTitle,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: check
                        ? Colors.white
                        : onIt.value
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
                  id,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: check
                        ? Colors.white
                        : onIt.value
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
                    color: check
                        ? Colors.white
                        : onIt.value
                            ? Colors.white
                            : AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: onIt.value ? 20.0 : 16.0,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(width: 1, color: Colors.red),
                        color: Colors.red[200],
                      ),
                      child: const Text('Wait',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 10.0),
                    SizedBox(
                      width: 100,
                      height: 30.0,
                      child: CustomButton(text: "Exam", onTap: examFunction),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
