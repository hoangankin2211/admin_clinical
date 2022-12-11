import 'package:admin_clinical/models/medicine.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/invoice.dart';
import '../../form/widgets/patient_information_form.dart';

class InvoiceForm extends StatelessWidget {
  const InvoiceForm(
      {super.key,
      required this.invoice,
      required this.patientId,
      required this.numberOfService,
      required this.numberOfMedicine,
      required this.totalMoney});
  final Invoice invoice;
  final String patientId;
  final int numberOfService;
  final int numberOfMedicine;
  final double totalMoney;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Invoice Information',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.red[400]),
        ),
        const SizedBox(height: 3),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: DisplayInformationWidget(
                      label: 'Invoice ID', content: invoice.id)),
              const SizedBox(width: 5),
              Expanded(
                child: DisplayInformationWidget(
                    label: 'Patient ID', content: patientId),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Create Date',
                  content: DateFormat().add_yMMMMd().format(invoice.createTime),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              const SizedBox(width: 5),
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Invoice Category',
                  content: invoice.category,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Invoice Title',
                  content: invoice.title,
                ),
              ),
              const SizedBox(width: 5),
              const Expanded(
                child: DisplayInformationWidget(
                  label: 'Invoice Status',
                  content: 'All Invoices',
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Amount',
                  content: invoice.amount.toString(),
                ),
              ),
              const SizedBox(width: 5),
              const Expanded(
                child: DisplayInformationWidget(
                  label: 'Discount',
                  content: '10%',
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: DisplayInformationWidget(
                  label: 'Real Pay',
                  content: totalMoney.toString(),
                ),
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ],
    );
  }
}
