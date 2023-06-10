import 'dart:convert';

class Product {
  String? id;
  String? catId;
  String name;
  String description;
  num price;
  num oldPrice;
  String imageUrl;
  String category;
  num rate;

  Product(
      {this.id,
      this.catId,
      required this.name,
      required this.description,
      required this.price,
      required this.imageUrl,
      required this.category,
      required this.oldPrice,
      required this.rate});

  Map<String, dynamic> toMap() {
    return {
      'productName': name,
      'productDescription': description,
      'productImage': imageUrl,
      'productCategory': category,
      'productRate': 3,
      'productPrice': price,
      'productOldPrice': price,
      'productId': id
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        category: map['productCategory'],
        // catId: map['productCategory'] ?? '',
        name: map['productName'] ?? '',
        description: map['productDescription'] ?? '',
        price: map['productPrice'] ?? '',
        imageUrl: map['productImage'] ?? '',
        rate: map['productRate'] ?? '',
        id: map['productId'],
        oldPrice: map['productOldPrice']);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
