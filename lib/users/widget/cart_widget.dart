import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatelessWidget {
  CartWidget({super.key});
  final Stream<QuerySnapshot> _itemsStream = FirebaseFirestore.instance
      .collection('items')
      .orderBy("time_stamp", descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.deepPurple,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        data['images'].toString(),
                        width: MediaQuery.of(context).size.width,
                        height: 180,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Placeholder();
                        },
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
    );
  }
}
