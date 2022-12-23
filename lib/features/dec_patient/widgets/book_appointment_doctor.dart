import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../auth/widgets/custom_button.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../controller/dp_patinet_contnrolller.dart';

class BookAppointmentDoctor extends StatelessWidget {
  const BookAppointmentDoctor({
    Key? key,
    required this.widthDevice,
    required this.controller,
    required this.callNextPage,
  }) : super(key: key);

  final double widthDevice;
  final DpPatinetController controller;
  final Function() callNextPage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Book Doctor Appointment',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                  ),
                ),
                const Text(
                  'We would love to hear from you! Please fill in the\nrequired details and our team will get in touch\nwith you.',
                  style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontSize: 18.0,
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
                          controller: controller.idTextController,
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
                          onPressed: controller.selectPatinetFuncViewDoc,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: widthDevice / 4 - 80,
                  child: CustomTextFormField(
                    title: "Doctor Name",
                    controller: TextEditingController(
                      text: controller.selectDotor.value.name,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: widthDevice / 4 - 80,
                  child: CustomTextFormField(
                    title: "Patient Name",
                    controller: TextEditingController(
                      text: controller.selectPatientViewDoc.value.name,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: widthDevice / 4 - 80,
                  child: CustomTextFormField(
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This Field can not be emptied";
                      }
                      return null;
                    },
                    controller: controller.dobController,
                    onTap: () {
                      DateTime tempDateTime = DateTime.now();
                      Get.dialog(
                        Dialog(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.35,
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.25),
                                  child: CupertinoDatePicker(
                                    onDateTimeChanged: (value) {
                                      tempDateTime = value;
                                    },
                                    initialDateTime: DateTime.now(),
                                    maximumDate: DateTime.now(),
                                    minimumDate: DateTime(1950, 1, 1),
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.2,
                                      50,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.back(result: tempDateTime);
                                  },
                                  child: const Text(
                                    'Select',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ).then((value) {
                        if (value != null) {
                          controller.currentDateTime = value;
                          controller.dobController.text = DateFormat()
                              .add_yMMMMd()
                              .format(controller.currentDateTime);
                        }
                      });
                    },
                    title: 'Appointment Date',
                    hint: 'Select Date',
                  ),
                ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: widthDevice / 4 - 80.0,
                  child: CustomTextFormField(
                    controller: controller.symptomControllerViewDoc,
                    width: double.infinity,
                    title: 'Symptom',
                    hint: 'Describe your symptom',
                    maxLine: 10,
                  ),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  width: widthDevice / 4 - 80.0,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50.0,
                          child: CustomButton(
                              title: "Create ID", onPressed: callNextPage),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 50.0,
                          child: CustomButton(
                              title: "Book Doc",
                              onPressed: controller.bookingAppointmentViewDoc),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
