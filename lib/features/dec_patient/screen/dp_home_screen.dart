import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/auth/widgets/custom_button.dart';
import 'package:admin_clinical/features/dec_patient/controller/dp_patinet_contnrolller.dart';
import 'package:admin_clinical/features/dec_patient/screen/booking_medical_screen.dart';
import 'package:admin_clinical/features/dec_patient/widgets/dp_app_bar.dart';
import 'package:admin_clinical/routes/name_route.dart';
import 'package:admin_clinical/services/data_service/data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DpHomeScreen extends StatelessWidget {
  DpHomeScreen({super.key});
  final controller = Get.put(DpPatinetController());
  PageController? pageController = PageController();
  // final controller = Get.put()
  void switchPage(int index) {
    pageController!.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

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
          padding: EdgeInsets.all(20.0),
          child: DpApBar(
            switchPage: switchPage,
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          HomePage(swithcPage: switchPage),
          BookingMedicalScreen(switchPage: switchPage),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Function(int) swithcPage;
  const HomePage({
    Key? key,
    required this.swithcPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ListView(children: [
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
        AboutField(),
        DoctorViewField(),
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
                width: 50.0,
              ),
              RowFunc(
                title: 'Consult Online',
                subitle: 'Talk to a doctor online',
                icon: FontAwesome.medkit,
              ),
              SizedBox(
                width: 50.0,
              ),
              RowFunc(
                title: 'Book Health Check ',
                subitle: 'Book a test online',
                icon: FontAwesome.medkit,
              ),
            ],
          ),
        ),
        Container(
            width: Get.width,
            height: Get.height / 2.5,
            color: Color.fromARGB(255, 3, 49, 87)),
      ]),
    );
  }
}

class RowFunc extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subitle;
  const RowFunc({
    Key? key,
    required this.icon,
    required this.title,
    required this.subitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 30.0),
        const SizedBox(width: 10.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 23.0)),
            Text(subitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0))
          ],
        )
      ],
    );
  }
}

class DoctorViewField extends StatelessWidget {
  const DoctorViewField({
    Key? key,
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
              Text(
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
                () => Row(
                  children: [
                    for (int i = 0; i < 3; i++)
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          margin: const EdgeInsets.symmetric(horizontal: 60.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 10.0),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                height: 400,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
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
                              Text(
                                'Khoa Than Kinh',
                                style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26.0),
                              ),
                              const Divider(thickness: 1),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ratings:",
                                    style: const TextStyle(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.yellowAccent),
                                      Text(
                                        '4.5  rating',
                                        style: const TextStyle(
                                          color: AppColors.headline1TextColor,
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
                onTap: () {},
                child: Text(
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
