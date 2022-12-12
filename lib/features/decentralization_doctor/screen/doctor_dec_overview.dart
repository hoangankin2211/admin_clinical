import 'dart:html';
import 'dart:js';

import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class DoctorDecOverview extends StatelessWidget {
  const DoctorDecOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _field1(),
                Expanded(
                  flex: 7,
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 10.0, left: 15.0, right: 15.0, bottom: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: AppColors.backgroundColor,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: Container(color: Colors.blue)),
        ],
      );
    });
  }

  Expanded _field1() {
    return Expanded(
      flex: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 15.0),
              const Text(
                'Good Morning ',
                style: TextStyle(
                    color: AppColors.headline1TextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 22.0),
              ),
              Text(
                'Dr.${AuthService.instance.user.name}',
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15.0,
                      ),
                    ],
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) => Container(
                    margin: const EdgeInsets.only(
                        top: 15.0, left: 15.0, right: 15.0, bottom: 10.0),
                    padding: const EdgeInsets.all(10.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor[300]!,
                          Colors.deepPurple[400]!,
                        ],
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Khach da kham',
                                  style: TextStyle(
                                    color: AppColors.headline1TextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                                const Text(
                                  '104',
                                  style: TextStyle(
                                    color: AppColors.headline1TextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 70.0,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Item1(
                                        header: "New Patients",
                                        data: 40,
                                        check: true,
                                        data1: 30),
                                    SizedBox(width: 20),
                                    Item1(
                                      header: "Old Patients",
                                      data: 30,
                                      check: false,
                                      data1: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: constraints.maxHeight - 20,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  NetworkImage(AuthService.instance.user.avt),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Item1 extends StatelessWidget {
  final String header;
  final int data;
  final bool check;
  final int data1;
  const Item1({
    Key? key,
    required this.header,
    required this.data,
    required this.check,
    required this.data1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color.fromARGB(255, 170, 217, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                data.toString(),
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: check ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Text(
                      '${data1.toString()}%',
                      style: TextStyle(
                          color: check ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
