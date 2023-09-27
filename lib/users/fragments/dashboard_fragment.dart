import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:socialmediafeedapp/users/fragments/home_fragment.dart';
import 'package:socialmediafeedapp/users/fragments/upload_item.dart';

class DashboardOfFragment extends StatelessWidget {
  DashboardOfFragment({super.key});

  final List<Widget> _fragmentScreen = [
    const HomeFragmentScreen(),
    const UploadItemFragmentScreen()
  ];
  final List _navigationButtonProperties = [
    {
      "active_icon": Icons.home,
      "non_active_icon": Icons.home_outlined,
      "label": "Home",
    },
    {
      "active_icon": Icons.add,
      "non_active_icon": Icons.add_outlined,
      "label": "Add",
    }
  ];

  final RxInt _indexNumber = 0.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(child: Obx(() => _fragmentScreen[_indexNumber.value])),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
              currentIndex: _indexNumber.value,
              onTap: (value) {
                _indexNumber.value = value;
              },
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white24,
              items: List.generate(2, (index) {
                var navBtnProperty = _navigationButtonProperties[index];
                return BottomNavigationBarItem(
                    backgroundColor: Colors.black,
                    icon: Icon(navBtnProperty["non_active_icon"]),
                    activeIcon: Icon(navBtnProperty["active_icon"]),
                    label: navBtnProperty["label"]);
              }))),
        );
      },
    );
  }
}
