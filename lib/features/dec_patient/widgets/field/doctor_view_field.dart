import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../services/data_service/data_service.dart';

class DoctorViewField extends StatelessWidget {
  final Function() nextPageCallback;
  const DoctorViewField({
    Key? key,
    required this.nextPageCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(
            left: constraints.maxWidth / 8,
            right: constraints.maxWidth / 8,
            bottom: constraints.maxHeight / 10,
            top: constraints.maxHeight / 10,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Meet Our ',
                      style: TextStyle(
                          color: AppColors.headline1TextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0)),
                  Text(
                    'Specialists',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              const Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 40.0),
              Obx(
                () => (DataService.instance.listDoctor.isEmpty)
                    ? const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.primaryColor))
                    : Row(
                        children: [
                          for (int i = 0; i < 3; i++)
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 60.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10.0),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 400,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(DataService
                                              .instance.listDoctor[i].avt!),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Text(
                                      DataService.instance.listDoctor[i].name!,
                                      style: const TextStyle(
                                          color: AppColors.headline1TextColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26.0),
                                    ),
                                    const Text(
                                      'Khoa Than Kinh',
                                      style: TextStyle(
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26.0),
                                    ),
                                    const Divider(thickness: 1),
                                    const SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Ratings:",
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                          ),
                                        ),
                                        const SizedBox(width: 20.0),
                                        Row(
                                          children: const [
                                            Icon(Icons.star,
                                                color: Colors.yellowAccent),
                                            Text(
                                              '4.5  rating',
                                              style: TextStyle(
                                                color: AppColors
                                                    .headline1TextColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: nextPageCallback,
                child: const Text(
                  'View all Doctor',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
