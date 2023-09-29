import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialmediafeedapp/users/model/upload_model.dart';

class ItemDetailsScreen extends StatefulWidget {
  ItemDetailsScreen(
      {super.key, required this.uploadItem, required this.timeStamp});
  final UploadItem uploadItem;

  String? timeStamp;

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.black54, Colors.deepPurple])),
        ),
        title: Text(widget.uploadItem.titleText!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 6,
                      color: Colors.deepPurpleAccent)
                ]),
            child: Column(
              children: [
                Image.network(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return const Placeholder();
                }, widget.uploadItem.images.toString()),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Text(
                    widget.uploadItem.titleText.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    widget.uploadItem.bodyText.toString(),
                    maxLines: 3,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 230),
                  child: Text(
                    widget.timeStamp.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
