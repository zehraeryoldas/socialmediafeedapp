import 'package:flutter/material.dart';
import 'package:socialmediafeedapp/users/fragments/dashboard_fragment.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardOfFragment(),
      debugShowCheckedModeBanner: false,
    );
  }
}
