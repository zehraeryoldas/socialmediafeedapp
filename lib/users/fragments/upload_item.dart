import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialmediafeedapp/users/service/upload_item_service.dart';

class UploadItemFragmentScreen extends StatefulWidget {
  const UploadItemFragmentScreen({super.key});

  @override
  State<UploadItemFragmentScreen> createState() =>
      _UploadItemFragmentScreenState();
}

class _UploadItemFragmentScreenState extends State<UploadItemFragmentScreen> {
  var formKey = GlobalKey<FormState>();

  //tarih eklenir
  final TextEditingController _titleText = TextEditingController();
  final TextEditingController _bodytext = TextEditingController();
  //resim alınacak

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
        title: const Text("Upload Form"),
        centerTitle: true,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black26,
                    offset: Offset(0, -3),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 8),
              child: Column(
                children: [
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          _myTextFormField(_titleText,
                              "please write text title", "Text title"),
                          const SizedBox(
                            height: 18,
                          ),
                          _myTextFormField(_bodytext, "please write body title",
                              "Body title"),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    UploadItemService().uploadItem(
                                        _titleText.text, _bodytext.text);
                                  }
                                  Fluttertoast.showToast(
                                      msg: "Upload item succesfully");
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 28,
                                  ),
                                  child: Text(
                                    "Upload new",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  TextFormField _myTextFormField(
      TextEditingController controller, String metin, String hintext) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white60,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white60,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white60,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 6,
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hintext,
      ),
      controller: controller,
      validator: (value) => value == "" ? metin : null,
    );
  }
}
