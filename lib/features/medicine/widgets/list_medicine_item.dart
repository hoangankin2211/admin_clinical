import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/list_item.dart';
import '../../../models/medicine.dart';

class ListMedicineItem extends StatelessWidget {
  final Medicine e;
  final VoidCallback select;
  final VoidCallback delete;
  const ListMedicineItem({
    Key? key,
    required this.e,
    required this.select,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem(
      checkShadow: true,
      widgets: [
        Row(children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.headline1TextColor.withOpacity(0.3),
                  blurRadius: 5.0,
                )
              ],
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  e.thumbnails,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              " ${e.name}",
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: AppColors.primarySecondColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          )
        ]),
        Text(
          e.type,
          style: const TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Text(
          e.amount.toString(),
          style: const TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const Text(
          '200',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Text(
          '\$${e.price}',
          style: const TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                onTap: delete,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red.withOpacity(0.6),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.delete, color: Colors.white),
                      Text(
                        " Delete",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 5.0),
              InkWell(
                onTap: select,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue.withOpacity(0.6),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.add, color: Colors.white),
                      Text(
                        " Add",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
