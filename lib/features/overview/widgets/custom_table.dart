import 'package:admin_clinical/constants/app_colors.dart';
import 'package:admin_clinical/features/overview/widgets/dismissible_table_row.dart';
import 'package:admin_clinical/models/medicine.dart';
import 'package:admin_clinical/models/service.dart';
import 'package:admin_clinical/services/data_service/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_decoration.dart';

class SelectHealthRecord extends StatelessWidget {
  const SelectHealthRecord({
    super.key,
    required this.id,
    required this.dateCreated,
    required this.totalMoney,
    required this.doctorInCharge,
    required this.departmentId,
    required this.deleteCallback,
    required this.viewCallback,
  });
  final String id;
  final DateTime dateCreated;
  final double totalMoney;
  final String doctorInCharge;
  final String departmentId;
  final VoidCallback deleteCallback;
  final VoidCallback viewCallback;

  @override
  Widget build(BuildContext context) {
    final List<String> data = [
      id,
      DateFormat().add_yMMMMd().format(dateCreated),
      totalMoney.toString(),
      doctorInCharge,
      departmentId,
    ];
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(6),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 5),
          ...data
              .map(
                (element) => Expanded(
                  child: Text(
                    element,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: deleteCallback,
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
                const SizedBox(width: 5.0),
                InkWell(
                  onTap: viewCallback,
                  child: const Icon(Icons.file_copy,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
        ],
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
    this.onClick,
    this.onSelectedAction,
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
  final Function(String)? onSelectedAction;
  final Function()? onClick;
  final Function(String)? removeEntries;

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
      yesHandleSelection: () async {
        final result = await PatientService.deletePatient(id, context);
      },
      isTitleRow: color != Colors.white,
      id: id,
      remove: removeEntries ?? (_) {},
      child: InkWell(
        onTap: color == Colors.white ? onClick : null,
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
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.blueGrey),
                      ),
                    ),
                  )
                  .toList(),
              (color == Colors.white)
                  ? PopupMenuButton<String>(
                      onSelected: (value) {
                        onSelectedAction!(value);
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem<String>(
                          value: 'Detail',
                          child: Text('Detail'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'Delete',
                          child: Text('Delete'),
                        ),
                        // const PopupMenuItem<String>(
                        //   value: 'Generate Invoice',
                        //   child: Text('Generate Invoice'),
                        // ),
                        const PopupMenuItem<String>(
                          value: 'Examination',
                          child: Text('Examination'),
                        ),
                      ],
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
    required this.color,
    this.onCheckButtonChange,
    required this.service,
    required this.isSelected,
  });
  final Service service;
  final Color color;
  final Function(bool, String)? onCheckButtonChange;
  final bool isSelected;

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
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    if (value != null) {
                      onCheckButtonChange!(value, service.id ?? " ");
                    }
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                service.id ?? "ID",
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                service.name ?? "Name",
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                service.departmentId ?? "departmentId",
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                service.description.toString(),
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

class ResultServiceTableRow extends StatelessWidget {
  const ResultServiceTableRow({
    super.key,
    required this.color,
    required this.service,
    this.deleteServiceChoice,
  });
  final Function(bool, String)? deleteServiceChoice;
  final Color color;
  final Service service;

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
            ...service.toMap().entries.map(
              (e) {
                int flex = 1;
                if (e.key.toString() == 'thumbnails') {
                  return const SizedBox();
                }
                if (e.key.toString() == '_id') {
                  flex = 2;
                }
                return Expanded(
                  flex: flex,
                  child: e.key.toString() != 'name'
                      ? Text(
                          e.value.toString(),
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/chichthuoc.png'),
                              radius: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              e.value.toString(),
                              style: const TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                );
              },
            ).toList(),
            const SizedBox(width: 5),
            if (deleteServiceChoice != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarySecondColor),
                onPressed: () => deleteServiceChoice!(false, service.id ?? " "),
                child: const Icon(
                  Icons.close_outlined,
                  color: Colors.white,
                ),
              ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

class MedicineTableRow extends StatelessWidget {
  const MedicineTableRow({
    super.key,
    required this.color,
    this.onCheckButtonChange,
    required this.medicine,
    required this.isSelected,
  });
  final Medicine medicine;
  final Color color;
  final Function(bool, String)? onCheckButtonChange;
  final bool isSelected;

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
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topLeft,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    if (value != null) {
                      onCheckButtonChange!(value, medicine.id);
                    }
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                medicine.id,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                medicine.name,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                medicine.type,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                medicine.unit,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                medicine.amount.toString(),
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
    this.deleteMedicineChoice,
    required this.amount,
  });
  final Function(bool, String)? deleteMedicineChoice;
  final Color color;
  final Medicine medicine;
  final double amount;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      'ID': medicine.id,
      'thumbnails': medicine.thumbnails,
      'Name': medicine.name,
      'Unit': medicine.unit,
      'Price Per Unit': medicine.price,
      'Amount': amount,
      'Type': medicine.type,
      'Description': medicine.description,
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
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 5),
            ...data.entries.map(
              (e) {
                int flex = 1;
                if (e.key.toString() == 'thumbnails') {
                  return const SizedBox();
                }

                if (e.key.toString() == 'ID') {
                  flex = 2;
                }
                return Expanded(
                  flex: flex,
                  child: e.key.toString() != 'name'
                      ? Text(
                          e.value.toString(),
                          style: const TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(medicine.thumbnails),
                              radius: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                e.value.toString(),
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.blueGrey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                );
              },
            ).toList(),
            const SizedBox(width: 5),
            if (deleteMedicineChoice != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primarySecondColor),
                onPressed: () => deleteMedicineChoice!(false, medicine.id),
                child: const Icon(
                  Icons.close_outlined,
                  color: Colors.white,
                ),
              ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
