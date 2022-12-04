import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../auth/widgets/custom_button.dart';
import '../controller/medicine_controller.dart';
import 'change_no_data_field.dart';

class DialogUpdateAmountMedicine extends StatelessWidget {
  const DialogUpdateAmountMedicine({
    Key? key,
    required this.controller,
    required this.i,
  }) : super(key: key);

  final MedicineController controller;
  final int i;

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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update amount of Medicine',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 10.0),
            const Divider(thickness: 0.6),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 10.0,
                      ),
                    ],
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        controller.listMedicine.value[i].thumbnails,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.listMedicine.value[i].name,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        '\$${controller.listMedicine.value[i].price}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Obx(
              () => ChangeNumberDataField(
                checkType: false,
                addCallback: () => controller.amount.value++,
                degCallback: () => (controller.amount.value > 0)
                    ? controller.amount.value--
                    : controller.amount.value -= 0,
                data: controller.amount.value,
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: CustomButton(
                title: "Add Medicines",
                onPressed: () =>
                    controller.updateAmountMedicine(Get.context!, i),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
