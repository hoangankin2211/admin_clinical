import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/overview/widgets/dismissible_table_row.dart';
import 'package:admin_clinical/features/patient/screens/patient_screen.dart';
import 'package:admin_clinical/models/medicine.dart';
import 'package:admin_clinical/models/patient.dart';
import 'package:admin_clinical/routes/name_route.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
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
    this.avt,
    required this.payment,
    this.removeEntries,
  });
  final String? avt;
  final String name;
  final String id;
  final String date;
  final String gender;
  final String diseases;
  final String status;
  final String payment;
  final Color color;
  final Function(String)? removeEntries;

  @override
  Widget build(BuildContext context) {
    print(avt);
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
      yesHandleSelection: () async {
        final result = await PatientService.deletePatient(id, context);
      },
      isTitleRow: color != Colors.white,
      id: id,
      remove: removeEntries ?? (_) {},
      child: InkWell(
        onTap: color == Colors.white
            ? () => Get.toNamed(PageName.patientDetailScreen)
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
                  ? CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      backgroundImage: (avt != null && avt!.isNotEmpty)
                          ? NetworkImage(
                              avt!,
                            ) as ImageProvider
                          : const AssetImage('images/user.png'),
                      radius: 20,
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

class ServiceTableRow extends StatelessWidget {
  const ServiceTableRow({
    super.key,
    required this.name,
    required this.id,
    required this.color,
    required this.departmentID,
    required this.isSelected,
    this.onCheckButtonChange,
  });
  final String name;
  final String id;
  final String departmentID;
  final bool isSelected;
  final Color color;
  final Function(bool)? onCheckButtonChange;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = {
      'name': name,
      'id': id,
      'departmentID': departmentID,
    };
    return InkWell(
      onTap: color == Colors.white ? () {} : null,
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
                ? Expanded(
                    child: Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        if (value != null) {
                          onCheckButtonChange!(value);
                        }
                      },
                    ),
                  )
                : const Expanded(
                    child: Text(
                      'Select',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
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
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class ResultServiceTableRow extends StatelessWidget {
  const ResultServiceTableRow({
    super.key,
    required this.name,
    required this.id,
    required this.color,
    required this.departmentID,
    required this.amount,
    required this.departmentCharge,
    required this.pricePerUnit,
    required this.amountPrice,
  });
  final String name;
  final String id;
  final String departmentID;
  final String amount;
  final String departmentCharge;
  final Color color;
  final String pricePerUnit;
  final String amountPrice;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = {
      'name': name,
      'id': id,
      'departmentID': departmentID,
      'departmentCharge': departmentCharge,
      'amount': amount,
      'pricePerUnit': pricePerUnit,
      'amountPrice': amountPrice,
    };
    return InkWell(
      onTap: color == Colors.white ? () {} : null,
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
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
            const SizedBox(width: 5),
            color == Colors.white
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primarySecondColor),
                    onPressed: () {},
                    child: const Icon(
                      Icons.close_outlined,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(
                    width: 52,
                  ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class MedicineTableRow extends StatelessWidget {
  MedicineTableRow({
    super.key,
    required this.color,
    this.onCheckButtonChange,
    required this.medicine,
  });
  final Medicine medicine;
  final Color color;
  final Function(bool, String)? onCheckButtonChange;

//   ValueBuilder<bool>(
//    initialValue: false,
//    builder: (value, update) => Switch(
//    value: value,
//    onChanged: (flag) {
//       update( flag );
//    },),
//    onUpdate: (value) => print("Value updated: $value"),
//  ),

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: color == Colors.white ? () {} : null,
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
                ? Expanded(
                    child: ValueBuilder<bool?>(
                        initialValue: false,
                        onUpdate: (value) => print("Value updated: $value"),
                        builder: (value, update) {
                          return Checkbox(
                            value: value,
                            onChanged: (value) {
                              update(value);
                              if (value != null) {
                                onCheckButtonChange!(value, medicine.id);
                              }
                            },
                          );
                        }),
                  )
                : const Expanded(
                    child: Text(
                      'Select',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                medicine.id,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                medicine.name,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(
                medicine.provider,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class ResultMedicineTableRow extends StatelessWidget {
  const ResultMedicineTableRow({
    super.key,
    required this.color,
    required this.medicine,
  });
  final Color color;
  final Medicine medicine;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: color == Colors.white ? () {} : null,
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
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            ...medicine
                .toMap()
                .entries
                .map(
                  (e) => Expanded(
                    child: Text(
                      e.value.toString(),
                      style: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
                .toList(),
            const SizedBox(width: 5),
            color == Colors.white
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primarySecondColor),
                    onPressed: () {},
                    child: const Icon(
                      Icons.close_outlined,
                      color: Colors.white,
                    ),
                  )
                : const SizedBox(
                    width: 52,
                  ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
