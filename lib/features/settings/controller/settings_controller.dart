import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/user.dart';
import '../../../services/auth_service/auth_service.dart';

class SettingController extends GetxController {
  final _auth = AuthService.instance;
  User getUser() => _auth.user;

  final List<String> dropDownRoleChoice = [
    'Doctor',
    'Assistant',
    'Director',
  ];
  Rx<int?> selectedRole = Rx<int?>(0);

  final Map<String, String> dropDownCountry = {
    'Vietnam': 'icons/vietnam.png',
    'United State': 'icons/united_states.png',
    'United Kingdom': 'icons/united_kingdom.png',
    'Indian': 'icons/india.png',
  };
  Rx<String> selectedCountry = Rx<String>('Vietnam');
}
