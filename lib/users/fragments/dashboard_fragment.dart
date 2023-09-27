import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return ();
  }
}
