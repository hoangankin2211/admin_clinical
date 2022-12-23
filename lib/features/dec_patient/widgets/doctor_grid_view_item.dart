import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../models/doctor.dart';
import '../controller/dp_patinet_contnrolller.dart';
import '../screen/dp_view_all_doctor_screen.dart';

class DoctorGridView extends StatelessWidget {
  final Doctor1 doc;
  final Function() onTap;
  final Function() bookOnTap;
  DoctorGridView({
    Key? key,
    required this.doc,
    required this.onTap,
    required this.bookOnTap,
  }) : super(key: key);
  RxBool onIt = false.obs;
  final controller = Get.find<DpPatinetController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {},
        onHover: (value) => onIt.value = value,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: (onIt.value) ? Colors.black45 : Colors.black12,
                  blurRadius: 10.0)
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: (onIt.value) ? constraints.maxWidth : 0,
                  height: 5,
                  color: AppColors.primaryColor,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        margin: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(doc.avt!)),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dr. ${doc.name!}',
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22.0,
                                            ),
                                          ),
                                          Text(
                                            getDepartMent(doc.departMent!,
                                                    controller.listDepartMent)
                                                .name!,
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color:
                                                  AppColors.headline1TextColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          Text(
                                            '${doc.experience} experiences',
                                            style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(thickness: 1),
                                  const SizedBox(height: 5.0),
                                  const Text(
                                    'OPD DAY / TIMING',
                                    style: TextStyle(
                                      color: AppColors.headline1TextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const Text(
                                    'Monday to Saturday : 10:00 am to 02:00 pm | Monday & Thursday : 09:00 am to 02:00 pm',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                      onTap: bookOnTap,
                                      child: const Text('Book an Appointment',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0,
                                          ))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: onTap,
                          child: AnimatedContainer(
                            margin: const EdgeInsets.all(10.0),
                            curve: Curves.fastOutSlowIn,
                            duration: const Duration(milliseconds: 200),
                            height: onIt.value ? 50 : 0,
                            width: onIt.value ? 50 : 0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: const Center(
                              child: Icon(Icons.remove_red_eye_outlined,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
