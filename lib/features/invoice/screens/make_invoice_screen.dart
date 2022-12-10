import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:admin_clinical/features/invoice/widgets/service_detail_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_decoration.dart';
import '../widgets/invoice_widget.dart';

class MakeInvoiceScreen extends StatelessWidget {
  MakeInvoiceScreen({super.key});

  final invoiceController = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.primaryDecorationContainer,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Row(
              children: [
                const Flexible(
                  child: InvoiceWidget(),
                ),
                Flexible(
                  child: FormCard(child: ServiceDetailWidget()),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
