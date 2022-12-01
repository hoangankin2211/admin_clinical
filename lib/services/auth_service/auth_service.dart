import 'dart:convert';
import 'dart:io';

import 'package:admin_clinical/routes/name_route.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:admin_clinical/main.dart';

import '../../constants/api_link.dart';
import '../../constants/error_handing.dart';
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
          AuthService.instance.setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Get.offAllNamed(PageName.dashBoard);
        },
      );
    } catch (e) {
      updataLoading();
    }
  }

  Future<Map<String, dynamic>> forgetPassword(
      BuildContext context, String email) async {
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
          jsonEncode(
            {
              'verify-success': 'verify-success',
              'token': extractedData['token']
            },
          ),
        );
        // IO.Socket socket = IO.io(
        //     ApiLink.uri,
        //     IO.OptionBuilder()
        //         .setTransports(['websocket']) // for Flutter or Dart VM
        //         .build());
        // socket.onConnect(
        //   (_) {
        //     print('sasdfsadf');
        //     socket.emit(
        //       'verify-success',
        //       jsonEncode(
        //         {
        //           'verify-success': 'verify-success',
        //           'token': extractedData['token']
        //         },
        //       ),
        //     );
        //   },
        // );

        // socket.on('verify', (jsonData) {
        //   print(jsonData);
        // });
        // socket.onDisconnect((_) => print('disconnect'));

        // socket.on('fromServer', (_) => print(_));
        // SocketIO socketIO = SocketIOManager().createSocketIO(ApiLink.uri, '/',
        //     query: 'token=${(extractedData['token']) as String}');
        // await socketIO.init();
        // await socketIO.subscribe('verify', (jsonData) {
        //   Map<String, dynamic> data = json.decode(jsonData);
        //   print(data);
        // });
        // await socketIO.connect();

        // await socketIO.sendMessage(
        //   'verify-success',
        //   json.encode({
        //     'content': 'verify-success-sent',
        //   }),
        // );
      }

      return extractedData;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  // void init() {
  //   currentUser = users[0];
  //   friendList =
  //       users.where((user) => user.chatID != currentUser.chatID).toList();
  //   socketIO = SocketIOManager().createSocketIO(
  //       '<ENTER_YOUR_SERVER_URL_HERE>', '/',
  //       query: 'chatID=${currentUser.chatID}');
  //   socketIO.init();
  //   socketIO.subscribe('receive_message', (jsonData) {
  //     Map<String, dynamic> data = json.decode(jsonData);
  //     messages.add(Message(
  //         data['content'], data['senderChatID'], data['receiverChatID']));
  //     notifyListeners();
  //   });
  //   socketIO.connect();
  // }

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
