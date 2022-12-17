import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DpHomeScreen extends StatelessWidget {
  const DpHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('Demo'),
    );
    return Scaffold(
      backgroundColor: AppColors.greyBackgroundCOlor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/doctor1.png',
                    fit: BoxFit.cover,
                    height: 50.0,
                    width: 50.0,
                  ),
                  const Text(
                    ' Clinical App',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Home',
                        style: TextStyle(
                          color: Color.fromARGB(255, 53, 72, 78),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 90),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Book an appointment',
                        style: TextStyle(
                          color: Color.fromARGB(255, 53, 72, 78),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 90),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'Find a Doctor',
                        style: TextStyle(
                          color: Color.fromARGB(255, 53, 72, 78),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 70),
                    SizedBox(
                      width: 250.0,
                      height: 50,
                      child: CustomButton1(title: "Book now", onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(children: [
        SizedBox(
          width: Get.width,
          height: Get.height,
          child: Row(
            children: const [
              TextDesField(),
              ImageField(),
            ],
          ),
        ),
        _aboutUsField(),
        SizedBox(
          width: Get.width,
          height: Get.height,
        ),
      ]),
    );
  }

  Container _aboutUsField() {
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

class TextDesField extends StatelessWidget {
  const TextDesField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  left: constraints.maxWidth / 8,
                  bottom: constraints.maxHeight / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Providing the best \nOnline medical',
                    style: TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 70.0,
                    ),
                  ),
                  const Text(
                    'Special Care and \nBest Treatment',
                    style: TextStyle(
                      color: Color.fromARGB(255, 5, 89, 128),
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'I must explain to you how all this mistaken idea of \ndenouncing pleasure and praising pain was born\nand i will give you a complete',
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
                    child: CustomButton1(title: "Contact Us", onPressed: () {}),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageField extends StatelessWidget {
  const ImageField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/doctor1.png',
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 500),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 80.0,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                            ),
                            child: const Icon(FontAwesome.medkit,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Newest',
                                style: TextStyle(
                                  color: AppColors.headline1TextColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(height: 2.0),
                              Text(
                                'Methodice',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth / 3.5,
                    ),
                    Container(
                      width: 250,
                      height: 250.0,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Channer',
                            style: TextStyle(
                              color: AppColors.headline1TextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Spacer(),
                          SizedBox(height: 5.0),
                          Item11(
                            headerIcon: Icons.handshake_outlined,
                            title: 'Welcome',
                          ),
                          Item11(
                            headerIcon: Icons.person_outline_sharp,
                            title: 'All Doctors',
                          ),
                          Item11(
                            headerIcon: Icons.help_outline_outlined,
                            title: 'Free Consulation',
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class Item11 extends StatelessWidget {
  final String title;
  final IconData headerIcon;
  const Item11({
    Key? key,
    required this.title,
    required this.headerIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.primaryColor.withOpacity(0.2)),
      child: Row(children: [
        Icon(headerIcon, color: AppColors.primaryColor),
        Text(
          ' $title',
          style: const TextStyle(
            color: AppColors.headline1TextColor,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        )
      ]),
    );
  }
}
