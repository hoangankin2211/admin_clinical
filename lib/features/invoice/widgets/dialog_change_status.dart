import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../models/invoice.dart';
import '../../auth/widgets/custom_button.dart';
import '../controllers/invoice_controller.dart';

class DialogChangeStatus extends StatelessWidget {
  final Invoice invoice;
  DialogChangeStatus({
    Key? key,
    required this.invoice,
  }) : super(key: key);
  final controller = Get.find<InvoiceController>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 400,
        width: 300,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
          border: Border.all(
            width: 2,
            color: AppColors.primaryColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Change Status',
              style: TextStyle(
                color: AppColors.headline1TextColor,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Divider(thickness: 0.7),
            const SizedBox(height: 10.0),
            Text(
              invoice.id,
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 1.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: AppDecoration.primaryBorder,
                borderRadius: AppDecoration.primaryRadiusBorder,
              ),
              child: Obx(
                () => DropdownButton<int>(
                  underline: const SizedBox(),
                  items: controller.listStatus
                      .asMap()
                      .entries
                      .map((e) => DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(
                              e.value,
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ))
                      .toList(),
                  value: controller.selectStatus.value,
                  onChanged: (value) {
                    controller.selectStatus.value = value!;
                  },
                ),
              ),
            ),
            const Spacer(),
            Obx(
              () => SizedBox(
                height: 40.0,
                width: double.infinity,
                child: CustomButton(
                  check: controller.loadingChangeStatus.value,
                  title: "Update",
                  onPressed: () =>
                      controller.changeStatusInvoice(context, invoice.id),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
