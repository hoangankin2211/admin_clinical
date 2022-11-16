import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import 'custom_text_form_field.dart';

// ignore: must_be_immutable
class AddPatientDialog extends StatelessWidget {
  AddPatientDialog({super.key, required this.height, required this.width});
  final double height;
  final double width;

  List<String> dropDownItem = ['+84', '+86', '+42', '+88', '+14', '+52', '+50'];
  late var phoneCode = dropDownItem.first.obs;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        height: height,
        width: width,
        constraints: BoxConstraints(maxHeight: height, maxWidth: width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Patient',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  InkWell(
                    onTap: Get.back,
                    child: Icon(
                      Icons.clear_outlined,
                      color: Colors.grey[350],
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.grey[350]!,
                thickness: 0.6,
                height: 0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextFormField(
                      width: width * 0.4,
                      title: 'First Name',
                      hint: 'Enter your first Name'),
                  const Spacer(),
                  CustomTextFormField(
                      width: width * 0.4,
                      title: 'Last Name',
                      hint: 'Enter your last name'),
                ],
              ),
              CustomTextFormField(
                  width: width,
                  title: 'Location',
                  hint: 'Enter your current Address'),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextFormField(
                      width: width * 0.4,
                      title: 'Patient Email',
                      hint: 'email@gmail.com'),
                  const Spacer(),
                  CustomTextFormField(
                    prefixWidget: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Obx(
                        () => DropdownButton<String>(
                          underline: const SizedBox(),
                          value: phoneCode.value,
                          items: dropDownItem
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            phoneCode.value = value ?? '';
                          },
                        ),
                      ),
                    ),
                    width: width * 0.4,
                    title: 'Phone Number',
                    hint: '123456',
                  ),
                ],
              ),
              CustomTextFormField(
                width: width,
                title: 'Symptom',
                hint: 'Describe your symptom',
                maxLine: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: Get.back,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      onPressed: Get.back,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 22),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
