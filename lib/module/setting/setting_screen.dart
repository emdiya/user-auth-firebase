import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_firebase/auth/controller/auth_controller.dart';
import 'package:user_auth_firebase/module/setting/controller/setting_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Setting"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: () => auth.signOutUser(),
              child: const Text("Logout"),
            ),
          )
        ],
      ),
    );
  }
}
