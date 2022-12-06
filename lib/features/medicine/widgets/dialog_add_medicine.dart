import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/utils.dart';
import '../../auth/widgets/custom_button.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../controller/medicine_controller.dart';
import 'change_no_data_field.dart';

class DialogAddNewMedicine extends StatefulWidget {
  DialogAddNewMedicine({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogAddNewMedicine> createState() => _DialogAddNewMedicineState();
}

class _DialogAddNewMedicineState extends State<DialogAddNewMedicine> {
  final controller = Get.find<MedicineController>();
  Uint8List? _image;
  Rx<DateTime> date = DateTime.now().obs;
  void selectedImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
      //convertoBytes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: Get.width / 2,
        height: Get.height / 2,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'New Medicine',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                const SizedBox(height: 20.0),
                _image != null
                    ? Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10.0,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(_image!),
                          ),
                        ),
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10.0,
                            ),
                          ],
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://media.istockphoto.com/id/1300036753/photo/falling-antibiotics-healthcare-background.jpg?s=612x612&w=0&k=20&c=oquxJiLqE33ePw2qML9UtKJgyYUqjkLFwxT84Pr-WPk='),
                          ),
                        ),
                      ),
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 150,
                  height: 30.0,
                  child: CustomButton(
                    title: "thumbnails",
                    onPressed: () => selectedImage(),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10.0),
            Container(
              width: 0.2,
              height: double.infinity,
              color: AppColors.primaryColor,
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    controller: controller.nameController,
                    title: "Name",
                    width: double.infinity,
                    hint: "Enter Name",
                    trailingIcon: const Icon(Icons.medication_liquid_outlined),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select Price',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(height: 5.0),
                            Obx(
                              () => ChangeNumberDataField(
                                checkType: true,
                                addCallback: () => controller.price.value++,
                                degCallback: () => (controller.price.value > 0)
                                    ? controller.price.value--
                                    : controller.price.value -= 0,
                                data: controller.price.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select Cost',
                              style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            const SizedBox(height: 5.0),
                            Obx(
                              () => ChangeNumberDataField(
                                checkType: true,
                                addCallback: () => controller.cost.value++,
                                degCallback: () => (controller.cost.value > 0)
                                    ? controller.cost.value--
                                    : controller.cost.value -= 0,
                                data: controller.cost.value,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      (controller.listType.isEmpty)
                          ? const SizedBox()
                          : Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Type ",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 1.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: AppDecoration.primaryBorder,
                                        borderRadius:
                                            AppDecoration.primaryRadiusBorder,
                                      ),
                                      child: Obx(
                                        () => DropdownButton<int>(
                                          underline: const SizedBox(),
                                          items: controller.listType
                                              .asMap()
                                              .entries
                                              .map((e) => DropdownMenuItem<int>(
                                                    value: e.key,
                                                    child: Text(
                                                      e.value,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4,
                                                    ),
                                                  ))
                                              .toList(),
                                          value: controller.selectType.value,
                                          onChanged: (value) {
                                            controller.selectType.value =
                                                value!;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(
                          width: (controller.listType.isEmpty) ? 0.0 : 10.0),
                      Expanded(
                        child: CustomTextFormField(
                          controller: controller.typeController,
                          title: "Type of Medicine",
                          width: double.infinity,
                          hint: "Enter new Type",
                          trailingIcon: const Icon(Icons.type_specimen),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  CustomTextFormField(
                    controller: controller.descriptionController,
                    maxLine: 2,
                    title: "Description",
                    width: double.infinity,
                    hint: "Enter Description",
                    trailingIcon: const Icon(Icons.description),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Unit: ",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 1.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: AppDecoration.primaryBorder,
                                  borderRadius:
                                      AppDecoration.primaryRadiusBorder,
                                ),
                                child: Obx(
                                  () => DropdownButton<int>(
                                    underline: const SizedBox(),
                                    items: controller.listUnit
                                        .asMap()
                                        .entries
                                        .map((e) => DropdownMenuItem<int>(
                                              value: e.key,
                                              child: Text(
                                                e.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4,
                                              ),
                                            ))
                                        .toList(),
                                    value: controller.selectUnit.value,
                                    onChanged: (value) {
                                      controller.selectUnit.value = value!;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      const SizedBox(width: 20.0),
                      Obx(
                        () => Expanded(
                          child: SizedBox(
                            height: 50.0,
                            child: CustomButton(
                              check: controller.isLoadingInsert.value,
                              title: 'Insert Medicine',
                              onPressed: () => controller.insertNewMedicine(
                                context,
                                _image,
                              ),
                            ),
                          ),
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
    );
  }
  // Widget changeNo(Function addCallback)
}
