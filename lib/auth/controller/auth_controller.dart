import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_firebase/home_screen.dart';

import '../screen/login_screen.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  final isRegisterloading = false.obs;
  final isSignInLoading = false.obs;

  User? user;

  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser;
    user = user;
    update();
  }

  Future<void> signUpUser({String? email, String? password}) async {
    isRegisterloading(true);
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!)
          .then((respone) {
        if (respone.credential.hashCode == 2011) {
          debugPrint(
              '------------------ hashcode - ${respone.credential.hashCode.toString()}');
          Get.snackbar('Sucessfully!', 'You sign up sucessfully',
              colorText: Colors.white, backgroundColor: Colors.green);
          Get.offAll(() => const LoginPage());
        }
      });
    } catch (message) {
      Get.snackbar('Error', message.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isRegisterloading(false);
  }

  Future<void> signInUser({String? email, String? password}) async {
    isSignInLoading(true);
    try {
      isSignInLoading(true);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((respone) {
        if (respone.credential.hashCode == 2011) {
          isSignInLoading(false);
          Get.snackbar(
            'Sucessfully!',
            'You sign in sucessfully',
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );
          isSignInLoading(false);
          Get.offAll(() => const HomeScreen());
        }
      });
    } catch (message) {
      isSignInLoading(false);
      Get.snackbar('Error', message.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    isSignInLoading(false);
  }

  //checkUser
  checkUser() {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  //Signout
  signOutUser() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut().then(
          (value) => Get.offAll(
            () => const LoginPage(),
          ),
        );
  }
}
