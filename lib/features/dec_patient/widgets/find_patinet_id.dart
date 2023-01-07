import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../auth/widgets/custom_button.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../controller/dp_patinet_contnrolller.dart';

class FindPatinetID extends StatelessWidget {
  const FindPatinetID({
    Key? key,
    required this.widthDevice,
    required this.controller,
  }) : super(key: key);

  final double widthDevice;
  final DpPatinetController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Find ID',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const SizedBox(height: 40.0),
              SizedBox(
                width: widthDevice / 4 - 80,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        hint: "Enter your Email",
                        title: "Email",
                        controller: controller.emailPatientFindController,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: widthDevice / 4 - 80,
                child: CustomTextFormField(
                  controller: controller.phoneNoPatientFindController,
                  prefixWidget: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Obx(
                      () => DropdownButton<String>(
                        underline: const SizedBox(),
                        value: controller.phoneCode.value,
                        items: controller.dropDownItem
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
                          controller.phoneCode.value = value ?? '';
                        },
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This Field can not be emptied";
                    }
                    return null;
                  },
                  title: 'Phone Number',
                  hint: '123456',
                ),
              ),
              const SizedBox(height: 40.0),
              SizedBox(
                width: widthDevice / 4 - 80,
                height: 45.0,
                child: CustomButton(
                  title: "Find ID",
                  onPressed: () => controller.findIdFunc(),
                ),
              ),
              const SizedBox(height: 40.0),
              Obx(
                () => controller.yourId.value != ""
                    ? SizedBox(
                        width: widthDevice / 4 - 80,
                        child: Row(
                          children: [
                            const Text(
                              'Your ID: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: AppColors.primaryColor),
                            ),
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(
                                  text: controller.yourId.value,
                                ),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: AppColors.headline1TextColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(),
              )
            ],
          ),
        ],
      ),
    );
  }
}
