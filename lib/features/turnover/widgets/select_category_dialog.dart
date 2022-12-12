import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/custom_button.dart';
import '../../patient/widgets/custom_text_form_field.dart';

class SelectCategoryDialog extends StatelessWidget {
  SelectCategoryDialog({
    Key? key,
  }) : super(key: key);

  @override
  final controller = Get.find<InvoiceController>();
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 300,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category ",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            children: const [
              CustomTextFormField(
                hint: "Enter Custom Name",
                width: 280,
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Obx(
            () => Expanded(
              child: ListView(
                children: [
                  ...controller.name.map(
                    (e) => Row(
                      children: [
                        Checkbox(
                            value: e["check"].value,
                            onChanged: (value) => e["check"].value = value),
                        Expanded(
                          child: Text(
                            '  ${e["name"]}',
                            style: const TextStyle(
                              color: AppColors.headline1TextColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: CustomButton(
                text: "Reset",
                onTap: () {},
                backgroundColor: AppColors.primaryColor.withOpacity(0.6)),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 40.0,
            child: CustomButton(
                text: "Apply",
                onTap: () {
                  controller.fetchDataByCategory();
                  Get.back();
                }
                // Navigator.of(context).pop(
                //   {
                //     'type': "category",
                //   },
                // ),
                ),
          ),
        ],
      ),
    );
  }
}
