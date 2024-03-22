import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_auth_firebase/module/profile/controller/user_controller.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_circle_avatar_image.dart';
import '../../widgets/custom_textfield.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final userCon = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatarImage(
                radius: 60,
                imageUrl: userCon.user?.photoURL ??
                    "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
              ),
            ),
            const Text("ID"),
            CustomTextField(
              enable: false,

              hintText: userCon.user?.uid ?? "Unknown",
            ),
            const SizedBox(height: 20),
            const Text("Full Name"),
            CustomTextField(
              hintText: userCon.user?.displayName ?? "Unknown",
              controller: userCon.fullNameController,
            ),
            const SizedBox(height: 20),
            const Text("Email"),
            CustomTextField(
              hintText: userCon.user?.email ?? "Unknown",
            ),
            const SizedBox(height: 20),
            const Text("Password"),
            const CustomTextField(
              hintText: "Password",
            ),
             const SizedBox(height: 20),
            const Text("Phone Number"),
            CustomTextField(
              hintText: userCon.user?.phoneNumber ?? "Unknown",
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 40,right: 40),
        child: CustomButton(
          height: 60,
          onPressed: () {
            userCon.updateUser(
              // photoURL: "https://emdiya.github.io/potfolio/assets/my_photo-b5cd2ac9.jpeg",
              displayName: userCon.fullNameController.text.toLowerCase(),
              email: userCon.emailController.text.toString(),
              password: userCon.passwordController.text.toString(),
              phoneNumber: userCon.phoneNumberController.text.toString()
            );
          },
          title: "Update",
        ),
      ),
    );
  }
}
