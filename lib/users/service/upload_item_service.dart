import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmediafeedapp/users/model/upload_model.dart';
import 'package:intl/intl.dart';

class UploadItemService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<String?> uploadItem(String? titleText, String? bodyText) async {
    try {
      UploadItem uploadItem =
          UploadItem(titleText: titleText, bodyText: bodyText);

      DocumentReference result = await FirebaseFirestore.instance
          .collection("items") // Firestore koleksiyonunun adını buraya ekleyin
          .add(uploadItem.toJson());
      var result2 = result.id;
      final now = DateTime.now();
      final formattedDate = DateFormat('dd MMM HH:mm').format(now);
      // Başarı durumunda Firestore'dan dönen belgenin ID'sini döndürün
      FirebaseFirestore.instance.collection("items").doc(result2).update({
        'id': result2,
        'productStatus': 1,
        'time_stamp': formattedDate,
      });
      return result.id;
    } catch (e) {
      // Hata durumunda hata mesajını döndürün
      print("hata: $e");
      return e.toString();
    }
  }
}
