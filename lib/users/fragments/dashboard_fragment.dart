import 'package:flutter/material.dart';

import 'package:socialmediafeedapp/users/fragments/home_fragment.dart';
import 'package:socialmediafeedapp/users/fragments/upload_item.dart';

class DashboardOfFragment extends StatefulWidget {
  const DashboardOfFragment({super.key});

  @override
  State<DashboardOfFragment> createState() => _DashboardOfFragmentState();
}

class _DashboardOfFragmentState extends State<DashboardOfFragment> {
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

  int _indexNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _fragmentScreen[_indexNumber],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            currentIndex: _indexNumber,
            onTap: (value) {
              setState(() {
                _indexNumber = value;
              });
            },
            showSelectedLabels: true,
            iconSize: 40,
            showUnselectedLabels: true,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.deepPurple.shade100,
            items: List.generate(2, (index) {
              var navBtnProperty = _navigationButtonProperties[index];
              return BottomNavigationBarItem(
                  icon: Icon(navBtnProperty["non_active_icon"]),
                  activeIcon: Icon(navBtnProperty["active_icon"]),
                  label: navBtnProperty["label"]);
            })));
  }
}
