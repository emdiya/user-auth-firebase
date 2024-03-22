import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:get/get.dart';
import 'package:user_auth_firebase/auth/controller/auth_controller.dart';
import 'package:user_auth_firebase/module/setting/setting_screen.dart';

import 'module/profile/screen/profile_screen.dart';
import 'module/widgets/custom_circle_avatar_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = Get.put(AuthController());

  final _controller = SideMenuController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    auth.getUser();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("---------------User ${auth.user}");
    return Scaffold(
      body: Row(
        children: [
          SideMenu(
            controller: _controller,
            backgroundColor: Colors.white,
            mode: SideMenuMode.open,
            builder: (data) {
              return SideMenuData(
                header: const Text(
                  'Kalidy',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                items: [
                  const SideMenuItemDataDivider(divider: Divider()),
                  SideMenuItemDataTile(
                    isSelected: _currentIndex == 0,
                    onTap: () => setState(() => _currentIndex = 0),
                    title: 'Dashboard',
                    hoverColor: Colors.blue,
                    titleStyle: const TextStyle(color: Colors.black),
                    icon: const Icon(Icons.home_outlined),
                    selectedIcon: const Icon(Icons.home),
                  ),
                  SideMenuItemDataTile(
                    isSelected: _currentIndex == 1,
                    onTap: () => setState(() => _currentIndex = 1),
                    title: 'Product',
                    selectedTitleStyle: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                    icon: const Icon(Icons.table_bar_outlined),
                    selectedIcon: const Icon(Icons.table_bar),
                    titleStyle: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  const SideMenuItemDataDivider(divider: Divider()),
                  const SideMenuItemDataTitle(title: "Account"),
                  SideMenuItemDataTile(
                    isSelected: _currentIndex == 2,
                    onTap: () => setState(() => _currentIndex = 2),
                    title: 'Profile',
                    selectedTitleStyle: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                    icon: const Icon(Icons.person_pin_circle_outlined),
                    selectedIcon: const Icon(Icons.people),
                    titleStyle: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  SideMenuItemDataTile(
                    isSelected: _currentIndex == 3,
                    onTap: () => setState(() => _currentIndex = 3),
                    title: 'Notification',
                    selectedTitleStyle: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                    icon: const Icon(Icons.notifications),
                    selectedIcon: const Icon(Icons.table_bar),
                    titleStyle: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  SideMenuItemDataTile(
                    isSelected: _currentIndex == 4,
                    onTap: () => setState(() => _currentIndex = 4),
                    title: 'Setting',
                    selectedTitleStyle: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                    icon: const Icon(Icons.settings),
                    selectedIcon: const Icon(Icons.table_bar),
                    titleStyle: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                ],
                footer: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.5)),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatarImage(
                          imageUrl: auth.user?.photoURL ??
                              "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              auth.user?.displayName ?? "Unknown",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              auth.user?.email ?? "",
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.more_horiz,
                          color: Colors.grey,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: _buildBodyContent(),
          ),
          SideMenu(
            position: SideMenuPosition.right,
            builder: (data) => const SideMenuData(
              customChild: Text('custom view'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyContent() {
    switch (_currentIndex) {
      case 0:
        return Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'Dashboard',
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      case 1:
        return Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'Product',
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      case 2:
        return const ProfileScreen();
      case 3:
        return Container(
          color: Colors.white,
          child: const Center(
            child: Text(
              'Notification',
              style: TextStyle(fontSize: 24),
            ),
          ),
        );
      case 4:
        return const SettingScreen();
      default:
        return Container();
    }
  }
}
