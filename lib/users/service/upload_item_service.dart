import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socialmediafeedapp/users/model/upload_model.dart';

class UploadItemService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<String?> uploadItem(String? titleText, String? bodyText) async {
    try {
      UploadItem uploadItem =
          UploadItem(titleText: titleText, bodyText: bodyText);

      DocumentReference result = await FirebaseFirestore.instance
          .collection("items") // Firestore koleksiyonunun adını buraya ekleyin
          .add(uploadItem.toJson());

      // Başarı durumunda Firestore'dan dönen belgenin ID'sini döndürün
      return result.id;
    } catch (e) {
      // Hata durumunda hata mesajını döndürün
      print("hata: $e");
      return e.toString();
    }
  }
}
