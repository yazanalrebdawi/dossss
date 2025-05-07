import 'package:flutter/material.dart';

abstract class AccountParams {
  void paramsDispose();
}

class SigninParams implements AccountParams {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();
  @override
  void paramsDispose() {
    email.dispose();
    password.dispose();
    emailNode.dispose();
    passwordNode.dispose();
  }
}
class CreateAccountParams extends SigninParams {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController nickName = TextEditingController();
  String? phoneNumber;
  String? image;
  String? dateOfBirth;

  final FocusNode firstnamedNode = FocusNode();
  final FocusNode lastnameNode = FocusNode();
  final FocusNode phonenumberNode = FocusNode();
  final FocusNode imageNode = FocusNode();
  final FocusNode dateNode = FocusNode();

  @override
  paramsDispose() {
    super.paramsDispose();
    firstName.dispose();
    nickName.dispose();
    firstnamedNode.dispose();
    lastnameNode.dispose();
    phonenumberNode.dispose();
    imageNode.dispose();
    dateNode.dispose();
  }
}
class ForgetPasswordParams extends CreateAccountParams{}

