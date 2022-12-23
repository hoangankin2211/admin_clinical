import 'package:admin_clinical/features/form/widgets/form_card.dart';
import 'package:admin_clinical/features/invoice/controllers/invoice_controller.dart';
import 'package:admin_clinical/features/patient/widgets/health_record_detail.dart';
import 'package:admin_clinical/models/invoice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_decoration.dart';
import '../../../models/medicine.dart';
import '../../../models/patient.dart';
import '../../../models/service.dart';

class VerifyInvoiceInformationScreen extends StatelessWidget {
  VerifyInvoiceInformationScreen({
    super.key,
    required this.patient,
    required this.medicines,
    required this.services,
    required this.invoice,
  });
  final Invoice invoice;
  final Patient patient;
  final List<Medicine> medicines;
  final List<Service> services;
  final invoiceController = Get.find<InvoiceController>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: Container(
          padding: AppDecoration.primaryPadding,
          width: constraints.maxWidth * 0.7,
          decoration: AppDecoration.primaryDecorationContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => invoiceController
                        .changePage(invoiceController.selectedPage.value - 1),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppColors.primarySecondColor,
                      size: 28,
                    ),
                  ),
                  const Spacer(),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 22),
                        backgroundColor: AppColors.primaryColor),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Save Invoice',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 22),
                        backgroundColor: Colors.blueGrey),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Delete Invoice',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              FormCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ClinicInvoiceInformation(invoiceId: invoice.id),
                    AppWidget.primaryDivider,
                    PatientInvoiceInformation(
                      address: patient.address,
                      patientName: patient.name,
                    ),
                    AppWidget.primaryDivider,
                    const SizedBox(height: 5),
                    const DateTimeInfoField(),
                    SizedBox(
                        height: constraints.maxHeight * 0.3,
                        child: ResultServiceIndicationView(services: services)),
                    AppWidget.primaryDivider,
                    SizedBox(
                        height: constraints.maxHeight * 0.3,
                        child: FormCard(
                            child: ResultMedicineIndicationView(
                                medicine: medicines))),
                    FormCard(
                        child: InvoiceAmountFormWidget(amount: invoice.amount)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ClinicInvoiceInformation extends StatelessWidget {
  const ClinicInvoiceInformation({super.key, required this.invoiceId});
  final String invoiceId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                filterQuality: FilterQuality.high,
                'assets/icons/app_icon.png',
                fit: BoxFit.cover,
                color: AppColors.primaryColor,
                height: 60,
                width: 60,
              ),
              const SizedBox(height: 10),
              Text(
                'INVOICE',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 10),
              Text(
                "Invoice ID: $invoiceId",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Invoice From',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            Text(
              'Clinic Name: Gia Lai Clinic',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "123, Le Thanh Ton, TP Pleiku, GiaLai Province",
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}

class PatientInvoiceInformation extends StatelessWidget {
  const PatientInvoiceInformation({
    super.key,
    required this.patientName,
    required this.address,
  });
  final String patientName;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Billed To',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 10),
              Text(
                patientName,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Text(
                address,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Payment Details',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 10),
              Text(
                "Debit Card",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Text(
                "XXXXXXXXXXXXXXX-2541",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Text("Vietcombank",
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontWeight: FontWeight.w500))
            ],
          ),
        ),
      ],
    );
  }
}

class DateTimeInfoField extends StatelessWidget {
  const DateTimeInfoField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        borderRadius: AppDecoration.primaryRadiusBorder,
        border: AppDecoration.primaryBorder,
        color: AppColors.primaryColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            'Issue Date: 18-11-2022',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Due Date: 18-11-2022',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Due Amount: 1.000.000',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class InvoiceAmountFormWidget extends StatelessWidget {
  const InvoiceAmountFormWidget({super.key, required this.amount});

  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: AppColors.backgroundColor,
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10.0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                'Tax',
                style: Theme.of(context).textTheme.headline5,
              ),
              const Spacer(),
              Text(
                '10%',
                style: TextStyle(
                  color: Colors.blueGrey[400],
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                'Additional Charges',
                style: Theme.of(context).textTheme.headline5,
              ),
              const Spacer(),
              Text(
                '\$100',
                style: TextStyle(
                  color: Colors.blueGrey[400],
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                'Discount',
                style: Theme.of(context).textTheme.headline5,
              ),
              const Spacer(),
              Text(
                '10%',
                style: TextStyle(
                  color: Colors.blueGrey[400],
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                'Sub total',
                style: Theme.of(context).textTheme.headline5,
              ),
              const Spacer(),
              Text(
                amount > 25 ? (amount - 20).toString() : (amount).toString(),
                style: TextStyle(
                  color: Colors.blueGrey[400],
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
          AppWidget.primaryDivider,
          Row(
            children: [
              const SizedBox(width: 5),
              Text(
                'Total Amount',
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: AppColors.primaryColor),
              ),
              const Spacer(),
              Text(
                amount.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: AppColors.primaryColor),
              ),
              const SizedBox(width: 5),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              'assets/images/signature.png',
              height: 50,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
