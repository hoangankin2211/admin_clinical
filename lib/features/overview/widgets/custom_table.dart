import 'package:admin_clinical/features/overview/widgets/dismissible_table_row.dart';
import 'package:admin_clinical/features/patient/screens/patient_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_decoration.dart';

class CurrentPatientTableRow extends StatelessWidget {
  const CurrentPatientTableRow({
    super.key,
    required this.name,
    required this.id,
    required this.date,
    required this.gender,
    required this.diseases,
    required this.status,
    required this.color,
    required this.avt,
  });
  final String avt;
  final String name;
  final String id;
  final String date;
  final String gender;
  final String diseases;
  final String status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> data = {
      'name': name,
      'id': id,
      'date': date,
      'gender': gender,
      'diseases': diseases,
      'status': status,
    };
    return InkWell(
      onTap: color == Colors.white
          ? () => Get.to(() => const Material(child: PatientScreen()))
          : null,
      borderRadius: AppDecoration.primaryRadiusBorder,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: color,
            borderRadius: AppDecoration.primaryRadiusBorder,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0.5),
                  color: Colors.grey[200]!,
                  blurRadius: 2)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            color == Colors.white
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      avt,
                      fit: BoxFit.cover,
                      height: 35,
                      width: 35,
                    ),
                  )
                : const SizedBox(
                    height: 35,
                    width: 35,
                  ),
            const SizedBox(width: 5),
            ...data.entries
                .map(
                  (e) => Expanded(
                    child: Text(
                      e.value,
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                .toList(),
            (color == Colors.white)
                ? InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert_outlined,
                    ),
                  )
                : const SizedBox(
                    width: 25,
                  ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class PatientListRow extends StatelessWidget {
  const PatientListRow({
    super.key,
    required this.name,
    required this.id,
    required this.date,
    required this.gender,
    required this.diseases,
    required this.status,
    required this.color,
    required this.avt,
    required this.payment,
    required this.removeEntries,
    required this.index,
  });
  final String avt;
  final String name;
  final String id;
  final String date;
  final String gender;
  final String diseases;
  final String status;
  final String payment;
  final int index;
  final Color color;
  final Function(int) removeEntries;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> data = {
      'Patient Name': name,
      'Id': id,
      'Date': date,
      'Gender': gender,
      'Diseases': diseases,
      'Status': status,
      'Payment': payment,
    };
    return DismissibleTableRow(
      isTitleRow: color != Colors.white,
      id: id,
      remove: removeEntries,
      index: index,
      child: InkWell(
        onTap: color == Colors.white
            ? () => Get.to(() => Material(child: PatientScreen()))
            : null,
        borderRadius: AppDecoration.primaryRadiusBorder,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 0.5),
                  color: Colors.grey[200]!,
                  blurRadius: 2)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 5),
              color == Colors.white
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        avt,
                        fit: BoxFit.cover,
                        height: 40,
                        width: 40,
                      ),
                    )
                  : const SizedBox(
                      height: 35,
                      width: 35,
                    ),
              const SizedBox(width: 5),
              ...data.entries
                  .map(
                    (e) => Expanded(
                      child: Text(
                        e.value,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.blueGrey),
                      ),
                    ),
                  )
                  .toList(),
              (color == Colors.white)
                  ? InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.more_vert_outlined,
                      ),
                    )
                  : Text(
                      'Action',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.blueGrey,
                          ),
                    ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
