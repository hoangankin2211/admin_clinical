import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../auth/widgets/custom_button.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../controller/dp_patinet_contnrolller.dart';

class ViewAllHealthRecord extends StatelessWidget {
  const ViewAllHealthRecord({
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
                'HealthRecord View',
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
                        hint: "Enter your ID",
                        title: "ID",
                        controller: controller.idPatinetSearchController,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: CustomButton(
                        title: 'Select',
                        onPressed: controller.searchHealthRecord,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40.0),
              Obx(
                () => Expanded(
                  child: SizedBox(
                    width: widthDevice / 4 - 80,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: controller.listHealthRecordSearch
                            .map(
                              (element) => Container(
                                margin: const EdgeInsets.all(5.0),
                                width: double.infinity,
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 10.0,
                                      height: 10.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: element.status ==
                                                'Waiting Examination'
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      DateFormat()
                                          .add_yMMMEd()
                                          .format(element.dateCreate),
                                      style: const TextStyle(
                                        color: AppColors.headline1TextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      element.id!,
                                      style: const TextStyle(
                                        color: AppColors.headline1TextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
