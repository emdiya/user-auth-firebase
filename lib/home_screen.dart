import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:get/get.dart';
import 'package:user_auth_firebase/controller/user_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = Get.put(UserController());


  @override
  void initState() {
    super.initState();
    auth.getUser();
    Future.delayed(const Duration(seconds: 3), () {
      auth.checkUser();
    });
  }

  final _controller = SideMenuController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                    isSelected: _currentIndex == 1,
                    onTap: () => setState(() => _currentIndex = 2),
                    title: 'Profile',
                    selectedTitleStyle: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                    icon: const Icon(Icons.person_pin_circle_outlined),
                    selectedIcon: const Icon(Icons.people),
                    titleStyle: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  SideMenuItemDataTile(
                    isSelected: _currentIndex == 1,
                    onTap: () => setState(() => _currentIndex = 3),
                    title: 'Notification',
                    selectedTitleStyle: const TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.black),
                    icon: const Icon(Icons.notifications),
                    selectedIcon: const Icon(Icons.table_bar),
                    titleStyle: const TextStyle(color: Colors.deepPurpleAccent),
                  ),
                  SideMenuItemDataTile(
                    isSelected: _currentIndex == 1,
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
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatarImage(
                          imageUrl:
                              "https://emdiya.github.io/potfolio/assets/my_photo-b5cd2ac9.jpeg",
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Em Diya",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              auth.user!.email ?? "",
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
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'body',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _controller.toggle();
                    },
                    child: const Text('change side menu state'),
                  )
                ],
              ),
            ),
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
}

class CircleAvatarImage extends StatelessWidget {
  final String imageUrl;

  const CircleAvatarImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
