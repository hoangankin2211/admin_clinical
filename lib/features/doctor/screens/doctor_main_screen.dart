import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class DoctorMainScreen extends StatelessWidget {
  const DoctorMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.headline1TextColor.withOpacity(0.2),
                    blurRadius: 10.0,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top Doctor",
                    style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                          ),
                          child: const Text(
                            "Dr.Nguyem Minh Hung",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0),
                          ),
                        ),
                        Container(
                          width: 400,
                          height: 500,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: const Border(
                              left: BorderSide(
                                  width: 10, color: AppColors.primaryColor),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.headline1TextColor
                                    .withOpacity(0.2),
                                blurRadius: 10.0,
                                offset: const Offset(10, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 220,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/doctor2.png',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "HEAD OF THE DEPARTMENT",
                                        style: const TextStyle(
                                            color: Colors.blueGrey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.0),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: const Icon(FontAwesome.twitter,
                                          color: AppColors.primaryColor),
                                    ),
                                    const SizedBox(width: 10.0),
                                    InkWell(
                                      onTap: () {},
                                      child: const Icon(FontAwesome.facebook,
                                          color: AppColors.primaryColor),
                                    ),
                                    const SizedBox(width: 10.0),
                                    InkWell(
                                      onTap: () {},
                                      child: const Icon(FontAwesome.google,
                                          color: AppColors.primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  "Doctors, also known as physicians, are licensed health professionals who maintain and restore human health through the practice of medicine. They examine patients, review their medical history, diagnose illnesses or injuries, administer treatment, and counsel patients on their health and well-being.",
                                  maxLines: 4,
                                  style: TextStyle(
                                      color: Colors.blueGrey, fontSize: 16.0),
                                ),
                              ),
                              const Spacer(),
                              const Divider(thickness: 1),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Dentist",
                                      style: const TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    const SizedBox(width: 20.0),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.yellowAccent),
                                        Text(
                                          '4.8 rating',
                                          style: const TextStyle(
                                            color: AppColors.headline1TextColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                const Divider(thickness: 1),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
