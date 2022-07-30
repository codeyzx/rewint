import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  String? id;
  String? title;
  String? videoUrl;
  String? duration;
  List<dynamic>? hasAccess;
  int? price;

  ShopModel({
    this.id,
    this.title,
    this.videoUrl,
    this.duration,
    this.hasAccess,
    this.price,
  });

  ShopModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot['id'] as String?,
        title = snapshot['title'] as String?,
        videoUrl = snapshot['videoUrl'] as String?,
        duration = snapshot['duration'] as String?,
        hasAccess = snapshot['hasAccess'] as List<dynamic>?,
        price = snapshot['price'] as int?;

  ShopModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        title = json['title'] as String?,
        videoUrl = json['videoUrl'] as String?,
        duration = json['duration'] as String?,
        hasAccess = json['hasAccess'] as List<dynamic>?,
        price = json['price'] as int?;

  // ShopModel.fromSnapshots(
  //     Stream<QuerySnapshot<Map<String, dynamic>>> snapshot)
  //     : id = snapshot.map((event) => event.data()!['id'] as String?).toString(),
  //       title = snapshot
  //           .map((event) => event.data()!['title'] as String?)
  //           .toString(),
  //       duration = snapshot
  //           .map((event) => event.data()!['duration'] as String?)
  //           .toString(),
  //       price = int.tryParse(
  //           snapshot.map((event) => event.data()!['price'] as int?).toString());

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'videoUrl': videoUrl,
        'duration': duration,
        'price': price,
        'hasAccess': hasAccess
      };
}
