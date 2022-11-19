import 'package:admin_clinical/features/invoice/screens/make_invoice_screen.dart';
import 'package:admin_clinical/features/invoice/screens/verify_invoice_information_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  var selectedPage = 0.obs;
  late final PageController pageController =
      PageController(initialPage: selectedPage.value, keepPage: true);
  late final List<Widget> pages = [
    MakeInvoiceScreen(),
    VerifyInvoiceInformationScreen()
  ];

  void changePage(int value) {
    if (value >= 0 && value < pages.length) {
      selectedPage.value = value;
    }
    pageController.animateToPage(
      selectedPage.value,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }
}
