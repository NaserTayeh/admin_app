import 'dart:developer';
import 'dart:io';

import 'package:firebase_app/admin/views/screens/main_admin_screen.dart';
import 'package:firebase_app/app_router/app_router.dart';
import 'package:firebase_app/auth/models/app_user.dart';
import 'package:firebase_app/data_repositories/auth_helper.dart';
import 'package:firebase_app/auth/screens/main_screen.dart';
import 'package:firebase_app/auth/screens/sign_in_screen.dart';
import 'package:firebase_app/data_repositories/firestore_helper.dart';
import 'package:firebase_app/data_repositories/storage_helper.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';

import '../../customer/views/customer_main_page.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> signInKey = GlobalKey();
  GlobalKey<FormState> signUpKey = GlobalKey();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  late String email;
  late String password;
  AppUser? loggedUser;
  saveEmail(String email) {
    this.email = email;
  }

  savePassword(String password) {
    this.password = password;
  }

  String? emailValidation(String email) {
    if (email == null || email.isEmpty) {
      return "Required field";
    } else if (!(isEmail(email))) {
      return "Incorrect email syntax";
    }
  }

  String? passwordValidation(String password) {
    if (password == null || password.isEmpty) {
      return "Required field";
    } else if (password.length <= 6) {
      return 'Error, the password must be larger than 6 letters';
    }
  }

  String? requiredValidation(String content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
  }

  String? phoneValidation(String content) {
    if (!isNumeric(content)) {
      return "InCorrect phone number syntax";
    }
  }

  signIn() async {
    if (signInKey.currentState!.validate()) {
      signInKey.currentState!.save();
      String? userId = await AuthHelper.authHelper
          .signIn(loginEmailController.text, passwordLoginController.text);
      if (userId != null) {
        loggedUser =
            await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
        notifyListeners();
        AppRouter.appRouter.goToWidgetAndReplace(MainAdminScreen());
      }
    }
  }

  SignUp() async {
    if (signUpKey.currentState!.validate()) {
      String? result = await AuthHelper.authHelper.signUp(
          registerEmailController.text, passwordRegisterController.text);
      if (result != null) {
        FirestoreHelper.firestoreHelper.addNewUser(AppUser(
            userpass: passwordRegisterController.text,
            id: result,
            email: registerEmailController.text,
            userName: userNameController.text,
            phoneNumber: phoneController.text));
        AppRouter.appRouter.goToWidgetAndReplace(MainAdminScreen());
      }
    }
  }

  getUser(String id) async {
    loggedUser = await FirestoreHelper.firestoreHelper.getUserFromFirestore(id);
    loggedUser!.id = id;
    notifyListeners();
  }

  checkUser() async {
    String? userId = AuthHelper.authHelper.checkUser();

    if (userId != null) {
      getUser(userId);
      AppRouter.appRouter.goToWidgetAndReplace(MainAdminScreen());
    } else {
      AppRouter.appRouter.goToWidgetAndReplace(SignInScreen());
    }
  }

  signOut() async {
    await AuthHelper.authHelper.signOut();
    AppRouter.appRouter.goToWidgetAndReplace(SignInScreen());
  }

  uploadNewFile() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(pickedFile!.path);
    String imageUrl =
        await StorageHelper.storageHelper.uploadNewImage('user_images', file);

    loggedUser!.imageUrl = imageUrl;

    await FirestoreHelper.firestoreHelper.updateTheUser(loggedUser!);
    getUser(loggedUser!.id!);
  }
}
