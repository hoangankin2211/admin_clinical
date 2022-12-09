import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../features/overview/controller/date_picker_controller.dart';
import '../app_colors.dart';

class DialogPickRangeDate extends StatelessWidget {
  final VoidCallback callback;
  final DateRangePicker controller;
  DialogPickRangeDate({
    Key? key,
    required this.controller,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 530,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.backgroundColor,
        ),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: SfDateRangePicker(
                selectionTextStyle:
                    const TextStyle(fontWeight: FontWeight.bold),
                rangeTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                headerStyle: const DateRangePickerHeaderStyle(
                  backgroundColor: AppColors.primaryColor,
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                monthCellStyle: const DateRangePickerMonthCellStyle(
                  textStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selectionColor: AppColors.primaryColor,
                rangeSelectionColor: AppColors.primaryColor.withOpacity(0.3),
                todayHighlightColor: AppColors.primaryColor,
                controller: controller.dateController,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: controller.selectionChanged,
                monthViewSettings: const DateRangePickerMonthViewSettings(
                    enableSwipeSelection: false),
              ),
            ),
            const Spacer(),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColor,
              ),
              child: ElevatedButton(
                onPressed: callback,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
