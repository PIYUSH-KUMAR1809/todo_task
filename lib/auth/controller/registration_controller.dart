import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  RxBool isObscure = true.obs;
  RxBool isObscure2 = true.obs;

  void updatePasswordStatus() {
    isObscure.value = !isObscure.value;
  }

  void updatePasswordStatus2() {
    isObscure2.value = !isObscure2.value;
  }
}
