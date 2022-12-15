import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/constants/app_decoration.dart';
import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/form/widgets/medicine_indication_widgets/result_medicine_indication.dart';
import 'package:admin_clinical/features/form/widgets/service_indication_widgets/result_indication.dart';
import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:admin_clinical/features/invoice/screens/make_invoice_screen.dart';
import 'package:admin_clinical/features/invoice/screens/verify_invoice_information_screen.dart';
import 'package:admin_clinical/models/health_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/medicine.dart';
import '../../../models/patient.dart';
import '../../../models/service.dart';
import '../../../services/data_service/medicine_service.dart';
import '../../../services/data_service/service_data_service.dart';

class ServiceDetailWidget extends StatelessWidget {
  ServiceDetailWidget({super.key, required this.patient});
  final Patient patient;

  final invoiceController = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: FormCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      backgroundImage:
                          (patient.avt != null && patient.avt!.isNotEmpty)
                              ? NetworkImage(
                                  patient.avt!,
                                ) as ImageProvider
                              : const AssetImage('images/user.png'),
                      radius: 25,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      patient.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 25),
                          shape: RoundedRectangleBorder(
                              borderRadius: AppDecoration.primaryRadiusBorder)),
                      onPressed: () {
                        Future(
                          () {
                            print(invoiceController
                                .selectedHealthRecord.value!.id);
                            print(invoiceController
                                .selectedHealthRecord.value!.services!.length);
                            print(invoiceController
                                .selectedHealthRecord.value!.medicines!.length);
                            HealthRecord healthRecord =
                                invoiceController.selectedHealthRecord.value!;
                            List<Medicine> medicines = [
                              if (healthRecord.medicines != null)
                                for (var element in healthRecord.medicines!)
                                  if (MedicineService.instance.getMedicine(
                                          element['medicine'] as String) !=
                                      null)
                                    MedicineService.instance.getMedicine(
                                        element['medicine'] as String)!
                            ];

                            List<Service> services = [
                              if (healthRecord.services != null)
                                for (var element in healthRecord.services!)
                                  if (ServiceDataService.instance.service[
                                          element['service'] as String] !=
                                      null)
                                    ServiceDataService.instance
                                        .service[element['service'] as String]!
                            ];
                            invoiceController.verifiedPage.value =
                                VerifyInvoiceInformationScreen(
                              invoice: invoiceController.selectedInvoice.value!,
                              medicines: medicines,
                              services: services,
                              patient: patient,
                            );
                          },
                        ).then((value) => invoiceController.changePage(
                            invoiceController.selectedPage.value + 1));
                      },
                      child: const Text(
                        'Approve All',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.primarySecondColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 25),
                          shape: RoundedRectangleBorder(
                              borderRadius: AppDecoration.primaryRadiusBorder)),
                      onPressed: () {
                        invoiceController.changePage(0);
                      },
                      child: const Text(
                        'Cancel All',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Expanded(
                child: ResultIndication(
              tagBuilder: MakeInvoiceScreen.tagBuilder,
            )),
            const Expanded(
              child: FormCard(
                child: ResultMedicineIndication(
                    tagBuilder: MakeInvoiceScreen.tagBuilder),
              ),
            ),
          ],
        );
      },
    );
  }
}
