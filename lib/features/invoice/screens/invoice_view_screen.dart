import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';
import '../controllers/invoice_controller.dart';

class InvoiceView extends StatelessWidget {
  InvoiceView({super.key});
  final invoiceController = Get.find<InvoiceController>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: AppDecoration.primaryDecorationContainer,
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: invoiceController.pageController,
            children: invoiceController.pages,
          ),
        );
      },
    );
  }
}
