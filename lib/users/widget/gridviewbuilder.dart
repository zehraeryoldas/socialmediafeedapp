import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmediafeedapp/users/controller/all_stream.dart';

class GridviewBuilderWidget extends StatelessWidget {
  GridviewBuilderWidget({super.key});
  final AllStream _allStream = AllStream();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _allStream.getAllStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // veri bekleniyor göstergesi
        } else if (snapshot.hasError) {
          return Text('Bir hata oluştu: ${snapshot.error}');
        }
        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 0.9,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            DocumentSnapshot data = snapshot.data!.docs[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 160,
                  height: 120,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 2,
                            offset: const Offset(0, 0),
                            spreadRadius: 1)
                      ]),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          data['title_text'].toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        subtitle: Text(
                          data['body_text'].toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 90,
                          child: Text(data['time_stamp'].toString())),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
