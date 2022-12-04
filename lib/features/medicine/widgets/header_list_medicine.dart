import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/global_widgets/list_item.dart';

class HeaderListMedicine extends StatelessWidget {
  const HeaderListMedicine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListItem1(
      widgets: [
        Row(
          children: const [
            Text(
              "Name ",
              style: TextStyle(
                color: AppColors.primarySecondColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          ],
        ),
        Row(
          children: const [
            Text(
              "Type Medicine ",
              style: TextStyle(
                color: AppColors.primarySecondColor,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
          ],
        ),
        const Text(
          "Remaining ",
          style: TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const Text(
          "Sold ",
          style: TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const Text(
          "Price ",
          style: TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        const Text(
          "",
          style: TextStyle(
            color: AppColors.primarySecondColor,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ],
    );
  }
}
