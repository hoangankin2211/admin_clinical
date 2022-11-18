import 'package:flutter/material.dart';

import '../patient_information_form.dart';

class MedicineInformationForm extends StatelessWidget {
  MedicineInformationForm({super.key});

  final List<Map<String, String>> fakeData = [
    {
      'title': 'Record ID',
      'content': '123',
    },
    {
      'title': 'Doctor in Charge',
      'content': 'Hoang Ankin',
    },
    {
      'title': 'Date Create',
      'content': '17/11/2022',
    },
    {
      'title': 'Prescription Date',
      'content': 'Admin',
    },
    {
      'title': 'Provider',
      'content': 'Medicine Department',
    }
  ];

  @override
  Widget build(BuildContext context) {
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
              for (int i = 2; i < 4; i++)
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
          child: DisplayInformationWidget(
            content: fakeData.elementAt(4)['content'] as String,
            label: fakeData.elementAt(4)['title'] as String,
          ),
        )
      ],
    );
  }
}
