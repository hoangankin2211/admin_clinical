import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../models/invoice.dart';

class InvoiceReportItem extends StatelessWidget {
  final Invoice element;
  InvoiceReportItem({
    Key? key,
    required this.element,
  }) : super(key: key);
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 30.0,
                    width: 30.0,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color:
                                AppColors.headline1TextColor.withOpacity(0.3),
                            blurRadius: 3.0)
                      ],
                    ),
                    child: const Icon(
                      Icons.payment,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    ' ${element.category}',
                    style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '\$ ${element.amount}',
                style: const TextStyle(
                  color: AppColors.headline1TextColor,
                  fontSize: 16.0,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${DateFormat().add_yMMMEd().format(element.createTime)} ${DateFormat().add_jm().format(element.createTime)}',
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: lColor1[element.status]),
                    child: Text(
                      listStatus[element.status],
                      style: TextStyle(
                          color: lColor2[element.status],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Divider(thickness: 1),
      ],
    );
  }
}
