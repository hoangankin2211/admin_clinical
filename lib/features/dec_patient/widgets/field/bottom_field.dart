import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../screen/dp_home_screen.dart';
import '../dp_row_func.dart';

class BottomField extends StatelessWidget {
  const BottomField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          color: AppColors.primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              RowFunc(
                title: 'Book Appintment',
                subitle: 'Choose by name, specialty...',
                icon: FontAwesome.medkit,
              ),
              SizedBox(
                width: 100.0,
              ),
              RowFunc(
                title: 'Consult Online',
                subitle: 'Talk to a doctor online',
                icon: Icons.phone,
              ),
              SizedBox(
                width: 100.0,
              ),
              RowFunc(
                title: 'Book Health Check ',
                subitle: 'Book a test online',
                icon: Icons.file_copy,
              ),
            ],
          ),
        ),
        SizedBox(
          width: Get.width,
          height: Get.height / 2.5,
          child: Stack(
            children: [
              Container(
                width: Get.width,
                height: Get.height / 2.2,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 3, 49, 87),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/background_login.jpg",
                    ),
                  ),
                ),
              ),
              Container(
                width: Get.width,
                height: Get.height / 2.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black54,
                      Colors.black87,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: Get.width / 1.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'About MGS',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    ...listAboutMgs.map((e) => InkWell(
                                          onTap: () {},
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Services',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    ...listServices.map((e) => InkWell(
                                          onTap: () {},
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/icons/app_icon.png',
                                      height: 100.0,
                                      width: 100.0,
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      children: listIcon
                                          .map((e) => Expanded(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    e,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'MGS SUPER SPECIALITY HOSPITAL',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    ...listIconTitleRow.map(
                                      (e) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0),
                                        child: Row(
                                          children: [
                                            Icon(e['icon'],
                                                color: Colors.white),
                                            Text(
                                              e['title'],
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Text(
                      '2021 © All right reserved. MGS Super Speciality Hospital Made by passion  iBrandox Online Pvt. Ltd.',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 50.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
