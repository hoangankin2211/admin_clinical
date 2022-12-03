import 'dart:typed_data';

import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/doctor/screens/doctor_profile_screen.dart';
import 'package:admin_clinical/features/patient/screens/list_patients_screen.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../constants/fake_data.dart';
import '../../../constants/global_widgets/custom_password_field.dart';
import '../../../constants/global_widgets/custom_text_field_icon_btn.dart';
import '../../../constants/utils.dart';
import '../../patient/widgets/custom_text_form_field.dart';
import '../controller/doctor_main_controller.dart';

class DialogAddNewDoctor extends StatefulWidget {
  DialogAddNewDoctor({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogAddNewDoctor> createState() => _DialogAddNewDoctorState();
}

class _DialogAddNewDoctorState extends State<DialogAddNewDoctor> {
  RxInt _value = 0.obs;

  final _passController = TextEditingController();
  Uint8List? _image;
  Rx<DateTime> date = DateTime.now().obs;
  void selectedImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
      //convertoBytes();
    });
  }

  final _rePassController = TextEditingController();

  final controller = Get.find<DoctorMainController>();

  @override
  Widget build(BuildContext context) {
    final heightDevice = MediaQuery.of(context).size.height;
    final widthDevice = MediaQuery.of(context).size.width;
    return Container(
      width: widthDevice - 200,
      height: heightDevice - 200,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person,
                  color: AppColors.primaryColor, size: 30.0),
              const Text(
                " Add new Doctor",
                style: TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  color: AppColors.headline1TextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          const Divider(thickness: 1),
          const SizedBox(height: 20.0),
          Expanded(
            child: Row(children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextFormField(
                            controller: controller.nameController,
                            title: "UserName",
                            width: double.infinity,
                            hint: "Enter Username",
                            trailingIcon: const Icon(Icons.person),
                          )),
                          const SizedBox(width: 20.0),
                          Expanded(
                              child: CustomTextFormField(
                            controller: controller.emailController,
                            title: "Email",
                            width: double.infinity,
                            hint: "Enter Email",
                            trailingIcon: const Icon(Icons.person),
                          )),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                              child: CustomPasswordField(
                                  controller: controller.passController,
                                  hintText: "Enter Password",
                                  labelText: "Password")),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Gender",
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
                                        items: DataService
                                            .instance.listDepartMent.value
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
                                        value:
                                            controller.selectDepartMent.value,
                                        onChanged: (value) {
                                          controller.selectDepartMent.value =
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
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 0.2, color: Colors.black),
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
                      const SizedBox(height: 30.0),
                      CustomTextFormField(
                        controller: controller.addressController,
                        title: "Address",
                        width: double.infinity,
                        hint: "Enter Address",
                        trailingIcon: const Icon(Icons.location_on_sharp),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextFormField(
                            controller: controller.phoneController,
                            title: "Phone Number",
                            width: double.infinity,
                            hint: "Enter Phone Number",
                            trailingIcon: const Icon(Icons.phone),
                          )),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: CustomTextFieldIconBtn(
                              title: "Country",
                              width: double.infinity,
                              callBack: () {},
                              trailingIcon: const Icon(Icons.arrow_drop_down),
                              hint: " Country",
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      CustomTextFormField(
                        controller: controller.descriptionController,
                        title: "Description",
                        maxLine: 4,
                        width: double.infinity,
                        hint: "Enter Description",
                      )
                    ],
                  )),
              const SizedBox(width: 10),
              Container(
                  width: 0.3, height: double.infinity, color: Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.2),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          _image == null
                              ? Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0)),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                        'assets/images/fake_avatar.jpg',
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0)),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: MemoryImage(_image!)),
                                  ),
                                ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 4,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0)),
                              gradient: LinearGradient(colors: [
                                Colors.black.withOpacity(0.3),
                                Colors.black.withOpacity(0.4)
                              ]),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () => selectedImage(),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.black.withOpacity(0.2)),
                                      child: Row(
                                        children: const [
                                          Icon(
                                            Icons.camera,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "  Pick Image",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: CustomButton(
                            title: "Create Doctor",
                            onPressed: () =>
                                controller.insertDoctor(context, _image),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
