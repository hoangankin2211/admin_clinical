import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../constants/api_link.dart';
import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../services/socket_service.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  late final PageController pageController;
  var currentPage = 0.obs;

  late final List<Widget> flowWidget = [
    EnterEmailPage(
      nextPage: () {
        if (currentPage.value > 0 && currentPage.value < 2) {
          currentPage.value = currentPage.value + 1;
          pageController.animateToPage(
            currentPage.value,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          );
        }
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      child: SafeArea(
        child: SizedBox(
          height: Get.height * 0.4,
          width: Get.width * 0.45,
          // child: PageView(
          //   controller: pageController,
          //   children: flowWidget,
          // ),
          child: EnterEmailPage(
            nextPage: () {
              if (currentPage.value > 0 && currentPage.value < 2) {
                currentPage.value = currentPage.value + 1;
                pageController.animateToPage(
                  currentPage.value,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class EnterEmailPage extends StatelessWidget {
  EnterEmailPage({super.key, required this.nextPage});
  final Function() nextPage;
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Find your account',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(height: 20),
          Divider(
            indent: 5,
            color: Colors.grey[350],
            thickness: 1.5,
          ),
          const SizedBox(height: 20),
          Text(
            "Please Enter your email to find your account.",
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              controller: textController,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.email_outlined),
                hintText: "Enter your Email",
                hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                labelText: 'Email',
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppDecoration.primaryRadiusBorder,
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 50,
            width: Get.width * 0.4,
            child: ElevatedButton(
              onPressed: () async {
                if (textController.text.isNotEmpty) {
                  final response = await AuthService.instance.forgetPassword(
                      context, textController.text, SocketService.socket);
                  if (response['isSentLink'] as bool) {}
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: AppDecoration.primaryRadiusBorder,
                ),
              ),
              child: const Text(
                "Sent Verification Email",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
