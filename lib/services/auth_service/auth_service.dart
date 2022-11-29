import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:admin_clinical/routes/name_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants/api_link.dart';
import '../../constants/error_handing.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();
  // ignore: prefer_final_fields
  User _user = User(
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    id: '',
    token: '',
    gender: '',
    phoneNumber: '',
    dateBorn: DateTime.now(),
    avt: '',
  );
  User get user => _user;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  bool get isLogin => user.id == '' ? false : true;

  Future<bool> getUserData() async {
    print('Get user data function');
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenRes = await http.post(
        Uri.parse('${ApiLink.uri}/api/validToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );
      var response = jsonDecode(tokenRes.body);
      if (response["check"]) {
        setUser(tokenRes.body);
        return true;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  // void logOut(BuildContext context) async {
  //   try {
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     await sharedPreferences.setString('x-auth-token', '');
  //     Get.offAllNamed(RouteNames.introScreen);
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  // }

  void signIn(
      {required BuildContext context,
      required String email,
      required String password,
      required VoidCallback updataLoading}) async {
    try {
      print("sign in function is called");
      var clinet = http.Client();
      http.Response res = await clinet.post(
        Uri.parse(
          '${ApiLink.uri}/api/signin',
        ),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        updataLoading();
      }
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          // DataService.instance.fetchAllData();
          AuthService.instance.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // Get.offAllNamed(RouteNames.dashboardScreen);
          Get.toNamed(PageName.dashBoard);
        },
      );
    } catch (e) {}
  }

  // void updateAvata(
  //     {required File file,
  //     required String email,
  //     required BuildContext context,
  //     required VoidCallback callback}) async {
  //   try {
  //     final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
  //     CloudinaryResponse imageRes = await cloudinary.uploadFile(
  //       CloudinaryFile.fromFile(file.path,
  //           resourceType: CloudinaryResourceType.Image, folder: email),
  //     );
  //     String imageUrl = imageRes.secureUrl;
  //     http.Response res = await http.post(
  //       Uri.parse(
  //         '${ApiLink.uri}/api/updateAvata',
  //       ),
  //       body: jsonEncode(
  //         {
  //           'email': email,
  //           'image': imageUrl,
  //         },
  //       ),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     print(res.body);
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () async {
  //         callback();
  //       },
  //     );
  //   } catch (err) {
  //     callback();
  //   }
  // }

  // void editProfile({
  //   required String name,
  //   required String email,
  //   required String gender,
  //   required String phoneNumber,
  //   required String address,
  //   required var dateBorn,
  //   required VoidCallback callBack,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse(
  //         '${ApiLink.uri}/api/editProfile',
  //       ),
  //       body: jsonEncode({
  //         'email': email,
  //         'name': name,
  //         'gender': gender,
  //         'phoneNumber': phoneNumber,
  //         'dateBorn': dateBorn,
  //         'address': address,
  //       }),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     print(res.body);
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () async {
  //         AuthService.instance.setUser(res.body);
  //         callBack();
  //       },
  //     );
  //   } catch (e) {
  //     callBack();
  //   }
  // }

  // void changePassWord(
  //     {required String password,
  //     required String newPassword,
  //     required BuildContext context,
  //     required VoidCallback callBack}) async {
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse(
  //         '${ApiLink.uri}/api/changePassword',
  //       ),
  //       body: jsonEncode({
  //         'email': AuthService.instance.user.email,
  //         'password': password,
  //         'newPassword': newPassword,
  //       }),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     print(res.body);
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () async {
  //         AuthService.instance.setUser(res.body);
  //         callBack();
  //       },
  //     );
  //   } catch (e) {
  //     callBack();
  //   }
  //   callBack();
  // }

  // void insertDoctor({
  //   required String type,
  //   required String description,
  //   required int timeStart,
  //   required int timeFinish,
  //   required int experience,
  //   required VoidCallback callback,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     http.Response res = await http.post(
  //       Uri.parse(
  //         '${ApiLink.uri}/api/doctors/insertDoctor',
  //       ),
  //       body: jsonEncode({
  //         'email': AuthService.instance.user.email,
  //         'type': type,
  //         'description': description,
  //         'timeStart': timeStart,
  //         'timeFinish': timeFinish,
  //         'experience': experience,
  //       }),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //     );
  //     print(res.body);
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () async {
  //         callback();
  //       },
  //     );
  //   } catch (e) {
  //     callback();
  //   }
  //   callback();
  // }
}



  // var response = jsonDecode(tokenRes.body);
      // if (response == true) {
      //   http.Response userRes = await http.get(
      //     Uri.parse("https://clinical-management-nmcnpm.herokuapp.com/getUser"),
      //     headers: <String, String>{
      //       'Content-Type': 'application/json; charset=UTF-8',
      //       'x-auth-token': token,
      //     },
      //   );
      //   print(userRes.body);
      //   // ignore: use_build_context_synchronously
      //   setUser(userRes.body);
      //   return false;
      // }