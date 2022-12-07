import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../app_colors.dart';

class DialogPickRangeDate extends StatelessWidget {
  DialogPickRangeDate({
    Key? key,
  }) : super(key: key);

  DateTime selectDateTemp1 = DateTime.now();
  DateTime selectDateTemp2 = DateTime.now();

  DateRangePickerController dateController = DateRangePickerController();
  Rx<DateTime> startDate = DateTime.now().obs;
  Rx<DateTime> finishDate = DateTime.now().obs;

  RxList<DateTime> allDateBetWeen = <DateTime>[].obs;
  final Rx<List<Map<String, dynamic>>> _dataChart =
      Rx<List<Map<String, dynamic>>>([]);
  List<Map<String, dynamic>> get dataChart => _dataChart.value;
  bool isSameDate(DateTime date1, DateTime date2) {
    if (date2 == date1) {
      return true;
    }
    if (date1 == null || date2 == null) {
      return false;
    }
    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }

  // change date select
  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    int firstDayOfWeek = DateTime.sunday % 7;
    int endDayOfWeek = (firstDayOfWeek - 1) % 7;
    endDayOfWeek = endDayOfWeek < 0 ? 7 + endDayOfWeek : endDayOfWeek;
    PickerDateRange ranges = args.value;
    DateTime date1 = ranges.startDate!;
    DateTime date2 = (ranges.endDate ?? ranges.startDate)!;
    if (date1.isAfter(date2)) {
      var date = date1;
      date1 = date2;
      date2 = date;
    }
    int day1 = date1.weekday % 7;
    int day2 = date2.weekday % 7;

    DateTime dat1 = date1.add(Duration(days: (firstDayOfWeek - day1)));
    DateTime dat2 = date2.add(Duration(days: (endDayOfWeek - day2)));

    if (!isSameDate(dat1, ranges.startDate!) ||
        !isSameDate(dat2, ranges.endDate!)) {
      dateController.selectedRange = PickerDateRange(dat1, dat2);
      selectDateTemp1 = dat1;
      selectDateTemp2 = dat2;
    }
  }

  //load data chart with select calendar
  selectDateDoneClick() {
    startDate.value = selectDateTemp1;
    finishDate.value = selectDateTemp2;
    allDateBetWeen.value = getListDateBetWeenRange();
    // getDataChart();
  }

  // get number date between
  getDayInBetWeen() {
    final int difference = finishDate.value.difference(startDate.value).inDays;
    return difference;
  }

  //get list date to load chart
  List<DateTime> getListDateBetWeenRange() {
    final items = List<DateTime>.generate(getDayInBetWeen() + 1, (index) {
      DateTime date = startDate.value;
      return date.add(Duration(days: index));
    });
    return items;
  }

  //get date start and date finish to load chart
  void getStartDateAndFinishDate() {
    DateTime now = DateTime.now();
    int weekDay = now.weekday == 7 ? 0 : now.weekday;
    startDate.value = DateTime.now();
    finishDate.value = DateTime.now();
    for (int i = 0; i < weekDay; i++) {
      startDate.value = startDate.value.add(const Duration(days: -1));
    }
    for (int i = 0; i < 6 - weekDay; i++) {
      finishDate.value = finishDate.value.add(const Duration(days: 1));
    }
    allDateBetWeen.value = List<DateTime>.generate(
        7, (index) => startDate.value.add(Duration(days: index)));
  }

  bool checkDateInList(DateTime date, List<DateTime> lDate) {
    for (var item in lDate) {
      if (date.day == item.day &&
          date.month == item.month &&
          date.year == item.year) return true;
    }
    return false;
  }

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
                controller: dateController,
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.range,
                onSelectionChanged: selectionChanged,
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
                onPressed: () {
                  // controller.selectDateDoneClick();
                  Get.back();
                },
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
