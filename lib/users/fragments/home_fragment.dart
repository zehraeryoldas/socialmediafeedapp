import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmediafeedapp/users/controller/all_stream.dart';
import 'package:socialmediafeedapp/users/widget/gridviewbuilder.dart';

class HomeFragmentScreen extends StatefulWidget {
  const HomeFragmentScreen({super.key});

  @override
  State<HomeFragmentScreen> createState() => _HomeFragmentScreenState();
}

class _HomeFragmentScreenState extends State<HomeFragmentScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.black54, Colors.deepPurple])),
        ),
        automaticallyImplyLeading: false,
        title: const Text("Home page"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.deepPurple)),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                    label: const Text("Search"),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                        icon: const Icon(
                          Icons.clear,
                          size: 30,
                        ))),
              ),
            ),
          ),
          GridviewBuilderWidget(),
        ],
      ),
    );
  }
}
