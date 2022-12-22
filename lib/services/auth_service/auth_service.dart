import 'dart:convert';
import 'dart:io';

import 'package:admin_clinical/routes/name_route.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';

import '../../constants/api_link.dart';
import '../../constants/error_handing.dart';
import '../../models/doctor.dart';
import '../../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  AuthService._privateConstructor();
  static final AuthService instance = AuthService._privateConstructor();
  // ignore: prefer_final_fields
  Doctor1 _doc = Doctor1(
    name: '',
    experience: 0,
    address: '',
    avt: '',
    dateBorn: DateTime.now(),
    departMent: '',
    description: '',
    iDBS: '',
    phoneNumber: '',
  );
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
  Doctor1 get doc => _doc;
  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setDoctor(String doc) {
    _doc = Doctor1.fromJson(jsonDecode(doc));
    print(_doc.name);
  }

  bool get isLogin => user.id == '' ? false : true;

  Future<bool> getUserData() async {
    print('Get user data function');
    if (_user.name == "") {
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
        return false;
      }
    }
    return true;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Get.offAllNamed(PageName.loginScreen);
    } catch (e) {
      // showSnackBar(context, e.toString());
    }
  }

  Future<bool> signIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    bool result = false;
    try {
      print("sign in function is called");
      var client = http.Client();
      http.Response res = await client.post(
        Uri.parse('${ApiLink.uri}/api/signin'),
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
      print('here');
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          print('Login successful');
          result = true;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          AuthService.instance.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // Get.offAllNamed(PageName.dashBoard);
        },
      );
    } catch (e) {
      print('signIn: $e');
    }
    return result;
  }

  Future<Map<String, dynamic>> forgetPassword(
      BuildContext context, String email, IO.Socket socket) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/forgetPassword',
        ),
        body: jsonEncode(
          {
            'email': email,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      Map<String, dynamic> extractedData = jsonDecode(res.body);
      print(extractedData);
      if (extractedData['isSentLink'] as bool) {
        socket.emit(
          'verify-success',
          {"token": extractedData['token']},
        );
      }

      return extractedData;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static Future<bool> applyNewPassword(String email, String newPassword) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/restorePassword',
        ),
        body: jsonEncode(
          {
            'email': email,
            'newPassword': newPassword,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      bool result = jsonDecode(res.body)['isSuccess'];
      return result;
    } catch (e) {
      print('applyNewPassword:$e');
      return false;
    }
  }

  void updateAvata(
      {required File file,
      required String email,
      required BuildContext context,
      required VoidCallback callback}) async {
    try {
      final cloudinary = CloudinaryPublic('ddopvilpr', 'evzte9pr');
      CloudinaryResponse imageRes = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(file.path,
            resourceType: CloudinaryResourceType.Image, folder: email),
      );
      String imageUrl = imageRes.secureUrl;
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/updateAvata',
        ),
        body: jsonEncode(
          {
            'email': email,
            'image': imageUrl,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          callback();
        },
      );
    } catch (err) {
      callback();
    }
  }

  void editProfile({
    required String name,
    required String email,
    required String gender,
    required String phoneNumber,
    required String address,
    required String? image,
    required var dateBorn,
    required VoidCallback callBack,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/editProfile',
        ),
        body: jsonEncode({
          'email': email,
          'name': name,
          'gender': gender,
          'phoneNumber': phoneNumber,
          'dateBorn': dateBorn,
          'address': address,
          'avt': image,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          AuthService.instance.setUser(res.body);
          callBack();
        },
      );
    } catch (e) {
      callBack();
    }
  }

  Future<bool> changePassword({
    required String password,
    required String newPassword,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
          '${ApiLink.uri}/api/changePassword',
        ),
        body: jsonEncode({
          'email': AuthService.instance.user.email,
          'password': password,
          'newPassword': newPassword,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res.body);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          _user.password = newPassword;
        },
      );

      return true;
    } catch (e) {
      return false;
    }
  }

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
