import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';

class ListInvoiceItem extends StatelessWidget {
  final String id;
  final String category;
  final DateTime date;
  final String image;
  final double amount;
  final int status;
  final bool check;
  final Function(bool?) onChange;
  final Function() deleteCallback;
  final Function(String)? onSelectedAction;

  ListInvoiceItem(
      {super.key,
      required this.id,
      required this.category,
      required this.date,
      required this.image,
      required this.amount,
      required this.status,
      this.onSelectedAction,
      required this.deleteCallback,
      required this.check,
      required this.onChange});
  RxBool checkBox = false.obs;
  List<Color> lColor1 = [
    Colors.blue.withOpacity(0.2),
    Colors.red.withOpacity(0.2),
    Colors.green.withOpacity(0.2),
  ];
  List<Color> lColor2 = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];
  List<String> listStatus = ["Cancelled", "Overdue", "Paid"];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Checkbox(value: check, onChanged: onChange),
              Expanded(
                child: Text(
                  id,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            category,
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '${DateFormat().add_yMMMEd().format(date)} ${DateFormat().add_jm().format(date)}',
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '\$ $amount',
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: lColor1[status]),
                child: Text(
                  listStatus[status],
                  style: TextStyle(
                      color: lColor2[status],
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  onSelectedAction!(value);
                },
                itemBuilder: (context) => [
                  const PopupMenuItem<String>(
                    value: 'View Invoice',
                    child: Text('View Invoice'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Change Status',
                    child: Text('Change Status'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Make Invoice',
                    child: Text('Make Invoice'),
                  ),
                ],
                child: const Icon(
                  Icons.more_vert_outlined,
                ),
              ),
              const SizedBox(width: 10.0),
              InkWell(
                onTap: deleteCallback,
                child: const Icon(Icons.delete, color: Colors.red),
              ),
              const SizedBox(width: 20.0),
            ],
          ),
        ),
      ]),
    );
  }
}
