import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

// class HandleSelectDate with RestorationMixin {
//   final Function(DateTime?) callBack;
//   HandleSelectDate({required this.callBack});
//   @override
//   String? get restorationId => restorationId;

//   final RestorableDateTime _selectedDate =
//       RestorableDateTime(DateTime(2021, 7, 25));
//   late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
//       RestorableRouteFuture<DateTime?>(
//     onComplete: callBack,
//     onPresent: (NavigatorState navigator, Object? arguments) {
//       return navigator.restorablePush(
//         _datePickerRoute,
//         arguments: _selectedDate.value.millisecondsSinceEpoch,
//       );
//     },
//   );
//   static Route<DateTime> _datePickerRoute(
//     BuildContext context,
//     Object? arguments,
//   ) {
//     return DialogRoute<DateTime>(
//       context: context,
//       builder: (BuildContext context) {
//         return
//       },
//     );
//   }

//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_selectedDate, 'selected_date');
//     registerForRestoration(
//         _restorableDatePickerRouteFuture, 'date_picker_route_future');
//   }
// }

// class HandleSelectDate extends StatelessWidget {
//   final Function(DateTime?) callBack;
//   final Object? arguments;
//   const HandleSelectDate({super.key, required this.callBack, this.arguments});

//   @override
//   Widget build(BuildContext context) {
//     return DatePickerDialog(
//       restorationId: 'date_picker_dialog',
//       initialEntryMode: DatePickerEntryMode.calendarOnly,
//       initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
//       firstDate: DateTime(2021),
//       lastDate: DateTime(2022),
//     );
//   }
// }
