import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../auth/widgets/custom_button.dart';

class AboutField extends StatelessWidget {
  const AboutField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/doctor4.png',
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 500),
                          child: Container(
                            width: constraints.maxWidth / 2.2,
                            height: constraints.maxHeight / 10.0,
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                )
                              ],
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/icons/app_icon.png',
                                  height: 100,
                                  width: 100,
                                  color: Colors.blue,
                                ),
                                const SizedBox(width: 10.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Dr Nguyen Minh Hung',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.0,
                                      ),
                                    ), //
                                    Text(
                                      'Head of hospital department',
                                      style: TextStyle(
                                        color: AppColors.headline1TextColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                    ),
                                    Text(
                                      'Khoa than kinh',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: constraints.maxWidth / 8,
                        right: constraints.maxWidth / 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'About Us',
                          style: TextStyle(
                            color: Color.fromARGB(255, 5, 89, 128),
                            fontWeight: FontWeight.bold,
                            fontSize: 50.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'St. John’s Hospital is a Registered Charity under the Charities Acts (Registered Charity No. 20000394) and is administered and managed in accordance with a Hospital Constitution approved by the Charities Regulatory Authority.  The current Hospital Constitution was approved in 2018.  The property is vested in Trustees.\n\nThe Hospital has a total of 99 beds – 89 In-Patient beds and 10 Day Care beds. The In-Patient specialties are General Medicine, General Surgery and Gynaecology',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        SizedBox(
                          width: 250.0,
                          height: 50,
                          child:
                              CustomButton1(title: "Explore", onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
