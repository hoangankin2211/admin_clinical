import 'dart:convert';
import 'package:admin_clinical/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'global_widgets/custom_dialog_error/error_dialog.dart';

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      // showSnackBar(context, jsonDecode(response.body)['msg']);
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
            question: "Sign In", title1: jsonDecode(response.body)['msg']),
      );
      break;
    case 500:
      // showSnackBar(context, jsonDecode(response.body)['error']);
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          question: "Sign In",
          title1: jsonDecode(response.body)['error'],
        ),
      );
      break;
    default:
      showSnackBar(context, response.body);
  }
}
