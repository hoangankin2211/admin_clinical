import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/patient/widgets/custom_text_form_field.dart';
import 'package:admin_clinical/features/settings/controller/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_decoration.dart';
import '../../auth/widgets/custom_button.dart';

// ignore: must_be_immutable
class NotificationSettingTab extends StatelessWidget {
  NotificationSettingTab({super.key});
  final controller = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<Map<String, dynamic>> listPrintCiple = [
      {
        'title': 'Maximum number of patients per day',
        'subtitle': 'Change maximum number of patients per day',
        'widget': CustomTextFormField(
          checkFormat: false,
          controller: controller.noPatientPerdayCOntroller,
          hint: "Enter maximum number of patients per day",
        ),
      },
      {
        'title': 'Examination Fee',
        'subtitle': 'Change examination Fee for person',
        'widget': CustomTextFormField(
          checkFormat: false,
          controller: controller.examinationFeeController,
          hint: "Enter examination Foor for per persons",
        ),
      },
    ];

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 160, vertical: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 0.2,
          ),
          borderRadius: AppDecoration.primaryRadiusBorder,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Principle Settings',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Divider(color: Colors.blueGrey[100], height: 10, thickness: 0.6),
              SingleChildScrollView(
                child: Column(
                  children: ListTile.divideTiles(
                    color: Colors.blueGrey[100],
                    context: context,
                    tiles: listPrintCiple.map(
                      (element) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  element['title'],
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                                Text(
                                  element['subtitle'],
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blueGrey[300],
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(width: 250, child: element['widget']),
                          ],
                        ),
                      ),
                    ),
                  ).toList(),
                ),
              ),
              Divider(color: Colors.blueGrey[100], height: 10, thickness: 0.6),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    width: constraints.maxWidth * 0.25,
                    child: Obx(
                      () => CustomButton(
                        title: 'Save Change',
                        onPressed: () => controller.editRegulation(),
                        check: controller.isLoading.value,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 40,
                    width: constraints.maxWidth * 0.2,
                    child: TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDecoration.primaryRadiusBorder,
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
  }
}
