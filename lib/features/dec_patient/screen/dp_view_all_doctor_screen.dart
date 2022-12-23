import 'package:admin_clinical/features/dec_patient/controller/dp_patinet_contnrolller.dart';
import 'package:admin_clinical/features/patient/widgets/custom_text_form_field.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../models/department.dart';
import '../../../models/doctor.dart';
import '../../../models/patient.dart';
import '../../auth/widgets/custom_button.dart';
import '../widgets/book_appointment_doctor.dart';
import '../widgets/doctor_grid_view_item.dart';
import '../widgets/doctor_view_dialog.dart';
import '../widgets/field/bottom_field.dart';

Department getDepartMent(String id, List<Department> list) =>
    list.firstWhere((element) => element.id == id);

class DpViewAllDoctor extends StatelessWidget {
  final Function() callNextPage;
  DpViewAllDoctor({super.key, required this.callNextPage});
  final controller = Get.find<DpPatinetController>();
  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    final heightDeivice = MediaQuery.of(context).size.height;
    RxBool checkShadow = true.obs;
    RxBool checkShadow1 = true.obs;
    RxBool checkShadow2 = true.obs;
    List<Map<String, dynamic>> listInfo = [
      {
        'image': 'assets/icons/people.svg',
        'title': 'patients',
        'data': '5.000+'
      },
      {
        'image': 'assets/icons/experiences.svg',
        'title': 'year experiences',
        'data': 4.3.toString(),
      },
      {'image': 'assets/icons/star.svg', 'title': 'rating', 'data': '4.8'},
      {'image': 'assets/icons/chat.svg', 'title': 'reviews', 'data': '4.942'},
    ];
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue[100]!,
                Colors.white,
              ],
            ),
          ),
          child: ListView(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Meet The World’s Best Doctors\nfrom anywhere in the world',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    width: widthDevice / 3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 10.0)
                      ],
                      border:
                          Border.all(width: 1, color: AppColors.primaryColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              hintText: 'Search here',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    height: 48.0,
                    width: 120,
                    child: CustomButton(
                      title: 'Search',
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: widthDevice / 1.7,
                      height: ((widthDevice / 1.7) / 3) *
                          (controller.listDoctor.length / 3).ceil(),
                      child: Obx(
                        () => controller.listDoctor.isNotEmpty &&
                                controller.listDepartMent.isNotEmpty
                            ? GridView.count(
                                shrinkWrap: false,
                                crossAxisCount: 3,
                                children: [
                                  ...controller.listDoctor.map(
                                    (element) => DoctorGridView(
                                      doc: element,
                                      bookOnTap: () {
                                        if (element != null) {
                                          controller.selectDotor.value =
                                              element;
                                        }
                                        checkShadow.value = false;
                                        Future.delayed(const Duration(
                                                milliseconds: 400))
                                            .then((value) =>
                                                checkShadow2.value = false);
                                      },
                                      onTap: () {
                                        if (element != null) {
                                          controller.selectDotor.value =
                                              element;
                                        }

                                        checkShadow.value = false;
                                        Future.delayed(const Duration(
                                                milliseconds: 400))
                                            .then((value) =>
                                                checkShadow1.value = false);
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                      )),
                ],
              ),
              const SizedBox(height: 50.0),
              const BottomField(),
            ],
          ),
        ),
        Obx(
          () => InkWell(
            onTap: () {
              checkShadow.value = true;
              checkShadow1.value = true;
              checkShadow2.value = true;
              controller.idTextController.clear();
              controller.selectPatientViewDoc = Patient(
                      avt: '',
                      id: '',
                      name: '',
                      gender: '',
                      address: '',
                      dob: '',
                      phoneNumber: '',
                      status: '')
                  .obs;
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: checkShadow.value ? 0 : widthDevice,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.black54,
                ],
              )),
            ),
          ),
        ),
        Obx(
          () => Center(
            child: DoctorViewDialog(
              widthDevice: widthDevice,
              checkShadow1: checkShadow1.value,
              heightDeivice: heightDeivice,
              controller: controller,
              listInfo: listInfo,
            ),
          ),
        ),
        Obx(
          () => Align(
            alignment: Alignment.bottomRight,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.all(40.0),
              curve: Curves.fastOutSlowIn,
              width: checkShadow2.value ? 0 : widthDevice / 4,
              height: heightDeivice - 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: BookAppointmentDoctor(
                  widthDevice: widthDevice,
                  controller: controller,
                  callNextPage: callNextPage),
            ),
          ),
        )
      ]),
    );
  }
}
