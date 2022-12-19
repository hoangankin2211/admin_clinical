import 'package:admin_clinical/features/dec_patient/controller/dp_patinet_contnrolller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/utils.dart';
import '../../auth/widgets/custom_button.dart';
import '../../patient/widgets/custom_text_form_field.dart';

class DpBookingAppointmentTab extends StatelessWidget {
  final double height;

  DpBookingAppointmentTab({
    Key? key,
    required this.height,
  }) : super(key: key);
  final controller = Get.find<DpPatinetController>();
  List<String> dropDownItem = ['+84', '+86', '+42', '+88', '+14', '+52', '+50'];
  late final phoneCode = dropDownItem.first.obs;
  TextEditingController symptomController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: height * 0.85,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(color: Colors.black26, blurRadius: 7.0)
                        ],
                        color: Colors.white,
                        border:
                            Border.all(width: 1, color: AppColors.primaryColor),
                      ),
                      child: TextFormField(
                        controller: controller.selectIdController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter Your ID",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    height: 50.0,
                    child: CustomButton(
                      title: "Select",
                      onPressed: controller.selectPatinetFunc,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Obx(
                () => Row(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      margin: const EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 7.0)
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(controller
                                      .selectPatient.value.avt !=
                                  ''
                              ? controller.selectPatient.value.avt!
                              : 'https://www.socra.org/blog/wp-content/uploads/2019/07/bannerNew1-1024x513.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomTextFormField(
                            controller: TextEditingController(
                                text: controller.selectPatient.value.name),
                            width: double.infinity,
                            title: 'Username',
                            hint: 'Select ID',
                            maxLine: 1,
                          ),
                          Utils.spaceSizeBoxAddPatientDialog,
                          CustomTextFormField(
                            controller: TextEditingController(
                              text: DateFormat()
                                  .add_yMMMMd()
                                  .format(DateTime.now()),
                            ),
                            width: double.infinity,
                            title: 'Date Create',
                            hint: 'Select ID',
                            maxLine: 1,
                          ),
                          Utils.spaceSizeBoxAddPatientDialog,
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(
                                  controller: TextEditingController(
                                    text: controller.selectPatient.value.email,
                                  ),
                                  width: double.infinity,
                                  title: 'Contact',
                                  hint: 'Select ID',
                                  maxLine: 1,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 1,
                                child: CustomTextFormField(
                                  controller: TextEditingController(
                                      text: controller
                                          .selectPatient.value.phoneNumber),
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Utils.spaceSizeBoxAddPatientDialog,
              CustomTextFormField(
                controller: symptomController,
                width: double.infinity,
                title: 'Symptom',
                hint: 'Describe your symptom',
                maxLine: 10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        const Divider(thickness: 1),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 40.0,
              child: CustomButton(
                title: 'Cancel All',
                onPressed: controller.canceleForm,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              height: 40.0,
              child: CustomButton(
                title: 'Booking',
                onPressed: controller.bookingAppointment,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
