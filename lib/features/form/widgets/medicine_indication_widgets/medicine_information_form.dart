import 'package:admin_clinical/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../patient_information_form.dart';

class MedicineInformationForm extends StatelessWidget {
  const MedicineInformationForm({
    super.key,
    this.id,
    this.amount,
    this.createDate,
  });

  final String? id;
  final double? amount;
  final DateTime? createDate;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> fakeData = [
      {
        'title': 'Record ID',
        'content': id,
      },
      {
        'title': 'Doctor in Charge',
        'content': AuthService.instance.user.name,
      },
      {
        'title': 'Date Create',
        'content': DateFormat().add_yMMMMd().format(DateTime.now()),
      },
      {
        'title': 'Amount',
        'content': amount ?? 0.0,
      },
      {
        'title': 'Provider',
        'content': 'Medicine Department',
      }
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Medicine Record Information',
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
              for (int i = 0; i < 2; i++)
                Expanded(
                  child: DisplayInformationWidget(
                    content: fakeData.elementAt(i)['content'].toString(),
                    label: fakeData.elementAt(i)['title'].toString(),
                  ),
                )
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 2; i < 4; i++)
                Flexible(
                  child: DisplayInformationWidget(
                    content: fakeData.elementAt(i)['content'].toString(),
                    label: fakeData.elementAt(i)['title'].toString(),
                  ),
                )
            ],
          ),
        ),
        Flexible(
          child: DisplayInformationWidget(
            content: fakeData.elementAt(4)['content'].toString(),
            label: fakeData.elementAt(4)['title'].toString(),
          ),
        )
      ],
    );
  }
}
