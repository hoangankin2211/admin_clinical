import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/global_widgets/custom_button.dart';
import '../../../constants/utils.dart';
import '../../../services/data_service/data_service.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../controller/doctor_main_controller.dart';

class DialogEditDoctor extends StatefulWidget {
  DialogEditDoctor({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogEditDoctor> createState() => _DialogEditDoctorState();
}

class _DialogEditDoctorState extends State<DialogEditDoctor> {
  RxInt _value = 0.obs;

  final controller = Get.find<DoctorMainController>();

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
    return Container(
      width: Get.width / 2,
      height: Get.height / 2,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Profile Doctor',
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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(controller.listDoctor
                              .value[controller.selectDoctor.value].avt!),
                        ),
                      ),
                    ),
              const SizedBox(height: 20.0),
              SizedBox(
                width: 150,
                height: 30.0,
                child: CustomButton(
                  text: "Choose Avt",
                  onTap: () => selectedImage(),
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
                CustomTextFormField(
                  controller: controller.nameController,
                  title: "UserName",
                  width: double.infinity,
                  hint: "Enter Username",
                  trailingIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  controller: controller.addressController,
                  title: "Address",
                  width: double.infinity,
                  hint: "Enter address",
                  trailingIcon: const Icon(Icons.location_history_sharp),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.2, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Obx(
                              () => Expanded(
                                child: Text(
                                  DateFormat()
                                      .add_yMMMEd()
                                      .format(controller.dateBorn.value),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final choice = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2030),
                                  initialDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Center(
                                        child: SizedBox(
                                      width: 1000.0,
                                      height: 1100.0,
                                      child: child,
                                    ));
                                  },
                                );
                                if (choice != null) {
                                  controller.dateBorn.value = choice;
                                }
                              },
                              child: const Icon(
                                Icons.calendar_month,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Obx(
                      () => Expanded(
                          child: Row(
                        children: [
                          const Text(
                            "Gender:   ",
                            style: TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          const Text(
                            "Male",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          Radio(
                            value: 0,
                            groupValue: _value.value,
                            onChanged: (value) {
                              _value.value = value!;
                            },
                            activeColor: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 40.0),
                          const Text(
                            "Fe Male",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                          Radio(
                            value: 1,
                            groupValue: _value.value,
                            onChanged: (value) {
                              _value.value = value!;
                            },
                            activeColor: AppColors.primaryColor,
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: controller.phoneController,
                        title: "Phone Number",
                        width: double.infinity,
                        hint: "Enter phone number",
                        trailingIcon: const Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Department ",
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
                                borderRadius: AppDecoration.primaryRadiusBorder,
                              ),
                              child: Obx(
                                () => DropdownButton<int>(
                                  underline: const SizedBox(),
                                  items:
                                      controller.listDepartMentForSearch.value
                                          .asMap()
                                          .entries
                                          .map((e) => DropdownMenuItem<int>(
                                                value: e.key,
                                                child: Text(
                                                  e.value.name!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4,
                                                ),
                                              ))
                                          .toList(),
                                  value: controller
                                      .selectDepartMentFotSearch.value,
                                  onChanged: (value) {
                                    controller.selectDepartMentFotSearch.value =
                                        value!;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                CustomTextFormField(
                  controller: controller.descriptionController,
                  title: "Description",
                  width: double.infinity,
                  maxLine: 3,
                  hint: "Enter descripion",
                  trailingIcon: const Icon(Icons.description),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Experiences',
                            style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border:
                                  Border.all(width: 0.2, color: Colors.grey),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.experince.value++;
                                  },
                                  icon: const Icon(Icons.add,
                                      color: Colors.black),
                                ),
                                const Spacer(),
                                Obx(
                                  () => Text(
                                    controller.experince.value.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    if (controller.experince.value > 0) {
                                      controller.experince.value--;
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end  ,
                        children: [
                          const SizedBox(height: 30.0),
                          SizedBox(
                              height: 50.0,
                              child: CustomButton(
                                onTap: () =>
                                    controller.editDoctor(context, _image),
                                text: "Update Doctor",
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
