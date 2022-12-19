import 'dart:typed_data';

import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/dec_patient/controller/dp_patinet_contnrolller.dart';
import 'package:admin_clinical/features/dec_patient/widgets/dp_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../constants/utils.dart';
import '../../../services/data_service/data_service.dart';
import '../../patient/widgets/custom_text_form_field.dart';

class BookingMedicalScreen extends StatelessWidget {
  final Function(int) switchPage;
  BookingMedicalScreen({super.key, required this.switchPage});
  PageController? pageController = PageController();
  // final controller = Get.put()
  void switchPage1(int index) {
    pageController!.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            width: constraints.maxWidth / 1.5,
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(20.0),
            margin: const EdgeInsets.only(top: 100.0, bottom: 40.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.backgroundColor,
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10.0),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/icons/app_icon.png',
                      color: AppColors.primaryColor,
                      width: 60,
                      height: 60,
                    ),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0),
                        children: [
                          TextSpan(
                              text: ' Booking An Appointment ',
                              style: TextStyle(color: AppColors.primaryColor)),
                          TextSpan(
                              text: 'Form',
                              style: TextStyle(
                                  color: Color.fromARGB(51, 5, 70, 101))),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomButton(
                        title: 'Create ID', onPressed: () => switchPage1(0)),
                    const SizedBox(width: 10.0),
                    CustomButton(
                        title: 'Booking', onPressed: () => switchPage1(1)),
                  ],
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DpCreateIdTab(
                            height: constraints.maxHeight,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: DpBookingAppointmentTab(
                            height: constraints.maxHeight,
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
      );
    });
  }
}

class DpBookingAppointmentTab extends StatelessWidget {
  final double height;

  DpBookingAppointmentTab({
    Key? key,
    required this.height,
  }) : super(key: key);
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
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Your ID"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    height: 50.0,
                    child: CustomButton(
                      title: "Select",
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Row(
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
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://www.socra.org/blog/wp-content/uploads/2019/07/bannerNew1-1024x513.jpg'),
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
                              text: "Truong Huynh Duc Hoang"),
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
                                  text: "hoangankin@gmail.com",
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
                                controller: phoneNumberController,
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
                                                    fontWeight: FontWeight.w500,
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
                onPressed: () {},
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
              height: 40.0,
              child: CustomButton(
                title: 'Booking',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class DpCreateIdTab extends StatefulWidget {
  final double height;
  DpCreateIdTab({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  State<DpCreateIdTab> createState() => _DpCreateIdTabState();
}

class _DpCreateIdTabState extends State<DpCreateIdTab> {
  final controller = Get.find<DpPatinetController>();
  Uint8List? _image;
  Rx<DateTime> date = DateTime.now().obs;
  void selectedImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);
    setState(() {
      _image = image;
      //convertoBytes();
    });
  }

  List<String> dropDownItem = ['+84', '+86', '+42', '+88', '+14', '+52', '+50'];
  List<String> dropDownItemGender = ["Male", "Female", 'Other'];
  List<String> dropDownItemStatus = ["Uncompleted", "Completed", 'Out-Patient'];
  List<String> dropDownItemDepartment = [
    for (var element in DataService.instance.listDepartMent) element.name ?? ""
  ];
  late final phoneCode = dropDownItem.first.obs;
  late final genderCode = dropDownItemGender.first.obs;
  late final statusCode = dropDownItemStatus.first.obs;
  late final departmentCode = dropDownItemDepartment.first.obs;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController symptomController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime currentDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: widget.height * 0.85,
          child: Row(
            children: [
              Column(
                children: [
                  _image != null
                      ? Container(
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
                              image: MemoryImage(_image!),
                            ),
                          ),
                        )
                      : Container(
                          height: 200,
                          width: 200,
                          margin: const EdgeInsets.only(bottom: 20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 7.0)
                            ],
                            image: const DecorationImage(
                              image: AssetImage('assets/images/doctor1.png'),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 40.0,
                    width: 200.0,
                    child: CustomButton(
                      title: "Select Avt",
                      onPressed: () => selectedImage(),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: fullNameController,
                      title: 'First Name',
                      hint: 'Enter your full Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This Field can not be emptied";
                        }
                        return null;
                      },
                    ),
                    Utils.spaceSizeBoxAddPatientDialog,
                    CustomTextFormField(
                      controller: locationController,
                      width: double.infinity,
                      title: 'Location',
                      hint: 'Enter your current Address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "This Field can not be emptied";
                        }
                        return null;
                      },
                    ),
                    Utils.spaceSizeBoxAddPatientDialog,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 2,
                          child: CustomTextFormField(
                            controller: emailController,
                            // width: width * 0.4,
                            title: 'Patient Email',
                            hint: 'email@gmail.com',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This Field can not be emptied";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 0.3, color: Colors.blueGrey)),
                            child: Obx(
                              () => DropdownButton<String>(
                                icon: const Icon(
                                  Icons.person_rounded,
                                  color: AppColors.primaryColor,
                                ),
                                underline: const SizedBox(),
                                value: genderCode.value,
                                items: dropDownItemGender
                                    .map((text) => DropdownMenuItem(
                                          value: text,
                                          child: Text(
                                            text,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  genderCode.value = value ?? '';
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: CustomTextFormField(
                            controller: phoneNumberController,
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
                                                fontWeight: FontWeight.w500,
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
                    Utils.spaceSizeBoxAddPatientDialog,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            readOnly: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This Field can not be emptied";
                              }
                              return null;
                            },
                            controller: dobController,
                            onTap: () {
                              DateTime tempDateTime = DateTime.now();
                              Get.dialog(
                                Dialog(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxHeight:
                                            MediaQuery.of(context).size.height *
                                                0.35,
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxHeight: MediaQuery.of(context)
                                                      .size
                                                      .height *
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
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            minimumSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
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
                                  currentDateTime = value;
                                  dobController.text = DateFormat()
                                      .add_yMMMMd()
                                      .format(currentDateTime);
                                }
                              });
                            },
                            title: 'Date Of Birth',
                            hint: 'Enter your your date of birth',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 0.3, color: Colors.blueGrey)),
                            child: Obx(
                              () => DropdownButton<String>(
                                icon: const Icon(
                                  Icons.local_activity_outlined,
                                  color: AppColors.primaryColor,
                                ),
                                underline: const SizedBox(),
                                value: statusCode.value,
                                items: dropDownItemStatus
                                    .map((text) => DropdownMenuItem(
                                          value: text,
                                          child: Text(
                                            text,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  statusCode.value = value ?? '';
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
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
                onPressed: () {},
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 10.0),
            SizedBox(
                height: 40.0,
                child: CustomButton(title: 'Create', onPressed: () {})),
          ],
        ),
      ],
    );
  }
}
