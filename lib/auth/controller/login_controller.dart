import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:todo_dev_task/auth/model/user_model.dart';
import 'package:todo_dev_task/utilities/shared_preferences.dart';
import 'package:todo_dev_task/widgets/custom_loader.dart';

import '../../utilities/logger.dart';

class LoginController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxBool isObscure = true.obs;

  void updatePasswordStatus() {
    isObscure.value = !isObscure.value;
  }

  Future<void> setLocalData(User user) async {
    await saveUserId(user.id.toString());
    await saveFirstName(user.firstName);
    await saveLastName(user.lastName);
    await saveUserEmail(user.email);
    await saveUserGender(user.gender);
    await saveUserImage(user.image);
    await saveUserName(user.username);
    await saveUserToken(user.token);
    await saveUserRefreshToken(user.refreshToken);

    logger.i(await getUserId());
    logger.i(await getUserName());
    logger.i(await getFirstName());
    logger.i(await getLastName());
    logger.i(await getUserToken());
    logger.i(await getUserRefreshToken());
    logger.i(await getUserGender());
    logger.i(await getUserImage());
    logger.i(await getUserEmail());
  }

  Future<dynamic> loginUser(
      String username, String password, BuildContext context) async {
    customLoader.showLoader(context);
    final url = Uri.parse('https://dummyjson.com/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    var responseData = jsonDecode(response.body);
    logger.i(response);
    logger.i(responseData);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      logger.i(responseData);
      User user = User.fromMap(responseData);
      await setLocalData(user);
      customLoader.hideLoader();
      return user.image;
      // Handle the successful login response
    } else {
      logger.i('Failed to login: ${response.statusCode}');
      customLoader.hideLoader();
      return false;
      // Handle the error response
    }
  }
}
