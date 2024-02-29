import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String docId;
  String name;
  String type;
  String image;
  String color;
  String brand;
  String size;
  String? userId;

  Product({
    required this.docId,
    required this.name,
    required this.type,
    required this.image,
    required this.color,
    required this.brand,
    required this.size,
    required this.userId,
  });

  factory Product.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      docId: doc.id,
      name: data['name'],
      type: data['type'],
      image: data['image'],
      color: data['color'],
      brand: data['brand'],
      size: data['size'],
      userId: data['userId'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "docId": docId,
      "type": type,
      "name": name,
      "image": image,
      "color": color,
      "brand": brand,
      "size": size,
      "userId": userId,
    };
  }
}
