import 'package:admin_clinical/features/form/widgets/patient_information_form.dart';
import 'package:flutter/material.dart';

class RecordInformationForm extends StatelessWidget {
  RecordInformationForm({super.key});

  final List<Map<String, String>> fakeData = [
    {
      'title': 'Record ID',
      'content': '123',
    },
    {
      'title': 'Date Create',
      'content': '17/11/2022',
    },
    {
      'title': 'Status',
      'content': 'Not good',
    },
    {
      'title': 'Department',
      'content': 'Polyclinic',
    },
    {
      'title': 'Doctor in Charge',
      'content': 'Hoang Ankin',
    },
    {
      'title': 'Total Money',
      'content': '1.000.000',
    },
    {
      'title': 'Note',
      'content': 'Co dien bien nang',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 3; i++)
                Expanded(
                  child: DisplayInformationWidget(
                    content: fakeData.elementAt(i)['content'] as String,
                    label: fakeData.elementAt(i)['title'] as String,
                  ),
                )
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 3; i < 6; i++)
                Flexible(
                  child: DisplayInformationWidget(
                    content: fakeData.elementAt(i)['content'] as String,
                    label: fakeData.elementAt(i)['title'] as String,
                  ),
                )
            ],
          ),
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 6; i < 7; i++)
                Expanded(
                  child: DisplayInformationWidget(
                    content: fakeData.elementAt(i)['content'] as String,
                    label: fakeData.elementAt(i)['title'] as String,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
