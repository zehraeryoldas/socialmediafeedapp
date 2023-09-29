import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:socialmediafeedapp/users/service/upload_item_service.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

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
  TextEditingController imagesController = TextEditingController();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(); // Resim yükleme işlemini başlat
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(); // Resim yükleme işlemini başlat
      } else {
        print('No image selected.');
      }
    });
  }

  String? indirmeBaglantisi;
  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      ref.putFile(_photo!);
      String url = await (await ref.putFile(_photo!)).ref.getDownloadURL();
      setState(() {
        indirmeBaglantisi = url;
        imagesController.text = url; // Resim URL'sini kontrolcüye ekleyin
      });
    } catch (e) {
      print('error occured');
    }
  }

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
                borderRadius: BorderRadius.circular(20), boxShadow: const []),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 8),
              child: Column(
                children: [
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          //   showDialogBoxForImagePickingAndCapturing(),
                          _myTextFormField(_titleText,
                              "please write text title", "Text title"),
                          const SizedBox(
                            height: 18,
                          ),
                          _myTextFormField(_bodytext, "please write body title",
                              "Body title"),
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: imageMethod(context),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Material(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate()) {
                                    UploadItemService().uploadItem(
                                        _titleText.text,
                                        _bodytext.text,
                                        imagesController.text);
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
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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

  GestureDetector imageMethod(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: CircleAvatar(
        radius: 55,
        backgroundColor: Colors.deepPurple,
        child: _photo != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _photo!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                width: 100,
                height: 100,
                child: Lottie.network(
                    "https://assets7.lottiefiles.com/packages/lf20_urbk83vw.json")),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Container _myTextFormField(
      TextEditingController controller, String metin, String hintext) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 3),
                blurRadius: 3,
                color: Colors.deepPurpleAccent)
          ]),
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.deepPurple,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.deepPurple,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.deepPurple,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.deepPurple,
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
      ),
    );
  }
}
