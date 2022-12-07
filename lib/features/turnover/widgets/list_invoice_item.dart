import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constants/app_colors.dart';

class ListInvoiceItem extends StatelessWidget {
  final String id;
  final String category;
  final DateTime date;
  final String image;
  final String name;
  final double amount;
  final int status;
  final Function(String)? onSelectedAction;

  ListInvoiceItem(
      {super.key,
      required this.id,
      required this.category,
      required this.date,
      required this.image,
      required this.name,
      required this.amount,
      required this.status,
      this.onSelectedAction});
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
        Obx(
          () => Expanded(
            flex: 2,
            child: Row(
              children: [
                Checkbox(
                    value: checkBox.value,
                    onChanged: (value) => checkBox.value = value!),
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
            DateFormat().add_yMMMEd().format(date),
            style: const TextStyle(
              color: AppColors.headline1TextColor,
              fontSize: 16.0,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Container(
                height: 30.0,
                width: 30.0,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.headline1TextColor.withOpacity(0.3),
                        blurRadius: 3.0)
                  ],
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(image)),
                ),
              ),
              Expanded(
                child: Text(
                  ' $name',
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
            mainAxisAlignment: MainAxisAlignment.end,
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
                    child: Text('change Status'),
                  ),
                ],
                child: const Icon(
                  Icons.more_vert_outlined,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
