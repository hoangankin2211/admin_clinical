import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../services/auth_service/auth_service.dart';
import '../item_one.dart';

class FieldOverviewDoctor extends StatelessWidget {
  const FieldOverviewDoctor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
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
                            child: SingleChildScrollView(
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
                                  // const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Item1(
                                        header: "New Patients",
                                        data: 40,
                                        check: true,
                                        data1: 30,
                                        size: constraints.maxHeight / 1.8,
                                      ),
                                      const SizedBox(width: 20),
                                      Item1(
                                        header: "Old Patients",
                                        data: 30,
                                        check: false,
                                        data1: 20,
                                        size: constraints.maxHeight / 1.8,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
