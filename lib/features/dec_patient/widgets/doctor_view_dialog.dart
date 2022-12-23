import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/app_colors.dart';
import '../../../models/department.dart';
import '../controller/dp_patinet_contnrolller.dart';

Department getDepartMent(String id, List<Department> list) =>
    list.firstWhere((element) => element.id == id);

class DoctorViewDialog extends StatelessWidget {
  const DoctorViewDialog({
    Key? key,
    required this.widthDevice,
    required this.checkShadow1,
    required this.heightDeivice,
    required this.controller,
    required this.listInfo,
  }) : super(key: key);

  final double widthDevice;
  final bool checkShadow1;
  final double heightDeivice;
  final DpPatinetController controller;
  final List<Map<String, dynamic>> listInfo;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(20.0),
      curve: Curves.fastOutSlowIn,
      width: widthDevice / 3,
      height: checkShadow1 ? 0 : heightDeivice / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: (controller.selectDotor.value.iDBS != '')
          ? SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 170.0,
                        height: 170.0,
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
                            image: NetworkImage(
                              controller.selectDotor.value.avt!,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dr. ${controller.selectDotor.value.name!}',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              getDepartMent(
                                      controller.selectDotor.value.departMent!,
                                      controller.listDepartMent)
                                  .name!,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: AppColors.headline1TextColor,
                                // fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Text(
                              '${controller.selectDotor.value.experience} experiences',
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.grey,
                                // fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Expanded(child: child)
                                for (var item in listInfo)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 60,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.primaryColor
                                                .withOpacity(0.2),
                                          ),
                                          child: SvgPicture.asset(item['image'],
                                              color: AppColors.primaryColor,
                                              height: 30),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          item['data'],
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          item['title'],
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          style: const TextStyle(
                                            color: AppColors.headline1TextColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            const Divider(thickness: 1),
                            const SizedBox(height: 10.0),
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
                            const Text(
                              'Description',
                              style: TextStyle(
                                color: AppColors.headline1TextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                            Text(
                              controller.selectDotor.value.description!,
                              style: const TextStyle(fontSize: 16.0),
                            ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
