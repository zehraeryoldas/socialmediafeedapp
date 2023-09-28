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
  final Stream<QuerySnapshot> _itemsStream = FirebaseFirestore.instance
      .collection('items')
      .orderBy("time_stamp", descending: true)
      .snapshots();
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black54, Colors.deepPurple])),
          ),
          automaticallyImplyLeading: false,
          title: const Text("Home page"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _itemsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // veri bekleniyor göstergesi
              } else if (snapshot.hasError) {
                return Text('Bir hata oluştu: ${snapshot.error}');
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.35,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        color: Colors.white,
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            "https://cdn.pixabay.com/photo/2017/11/29/09/15/paint-2985569_1280.jpg",
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: Text(
                              data['title_text'],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['body_text'],
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            trailing: Text(data['time_stamp'].toString()),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
        //GridviewBuilderWidget(),

        );
  }
}
