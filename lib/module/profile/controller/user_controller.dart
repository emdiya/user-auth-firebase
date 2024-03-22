import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  User? user;
  // TextEditingController instances for each text field
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  //
  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  Future<void> getUser() async {
    user = FirebaseAuth.instance.currentUser;
    user = user;
    update();
  }

  Future<void> updateUser({
    String? displayName,
    String? email,
    String? password,
    String? photoURL,
    String? phoneNumber,
    bool sendEmailVerification = false,
    bool deleteUser = false,
  }) async {
    try {
      if (displayName != null) {
        await user?.updateDisplayName(displayName);
      }
      if (photoURL != null) {
        await user?.updatePhotoURL(photoURL);
      }
      if (email != null) {
        await user?.verifyBeforeUpdateEmail(email);
        if (sendEmailVerification) {
          await user?.sendEmailVerification();
        }
      }
      if(phoneNumber != null){
         await updatePhoneNumber(phoneNumber);
      }
      if (password != null) {
        await user?.updatePassword(password);
      }
      if (deleteUser) {
        await user?.delete();
      }
      Get.snackbar(
        'Sucessfully!',
        'You sign in sucessfully',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      getUser(); // Refresh user data after update
    } catch (e) {
      // Handle error
      debugPrint("Failed to update user data: $e");
    }
  }

  Future<void> updatePhoneNumber(String phoneNumber) async {
    try {
      // Get a verification code from the user
      verificationCompleted(PhoneAuthCredential authCredential) async {
        await user?.updatePhoneNumber(authCredential);
        getUser(); // Refresh user data after update
      }

      verificationFailed(FirebaseAuthException authException) {
        // Handle verification failure
        debugPrint("Phone number verification failed: ${authException.message}");
      }

      codeSent(String verificationId, int? resendToken) async {
        // Handle code sent
        debugPrint("Verification code sent to $phoneNumber");
      }

      codeAutoRetrievalTimeout(String verificationId) {
        // Auto retrieval timeout
        debugPrint("Auto retrieval timeout for verification code");
      }
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
    } catch (e) {
      // Handle error
      debugPrint("Failed to update phone number: $e");
    }
  }
}
