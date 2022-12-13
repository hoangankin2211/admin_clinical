import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../models/invoice.dart';

class GridInvoiceItem extends StatelessWidget {
  final Invoice e;
  GridInvoiceItem({
    Key? key,
    required this.e,
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.headline1TextColor.withOpacity(0.3),
            blurRadius: 5.0,
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    e.id,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.headline1TextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: const Icon(
                    Icons.more_vert,
                    color: AppColors.primarySecondColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            color: AppColors.primaryColor.withOpacity(0.2),
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
                        fit: BoxFit.cover, image: NetworkImage(e.thumb)),
                  ),
                ),
                Expanded(
                  child: Text(
                    ' ${e.title}',
                    style: const TextStyle(
                      color: AppColors.headline1TextColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Amount",
                      style: TextStyle(
                          color: AppColors.primarySecondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    Text(
                      "\$ ${e.amount}",
                      style: const TextStyle(
                          color: AppColors.primarySecondColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Date Time",
                      style: TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      DateFormat().add_yMMMEd().format(e.createTime),
                      style: const TextStyle(
                        color: AppColors.primarySecondColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: lColor1[e.status]),
                child: Text(
                  listStatus[e.status],
                  style: TextStyle(
                      color: lColor2[e.status],
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
