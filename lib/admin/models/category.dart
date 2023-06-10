import 'dart:convert';

class Category {
  String? id;
  String imageUrl;
  String name;
  // String icon;
  Category(
      {required this.imageUrl,
      required this.name,
      // required this.icon,
      this.id});

  Map<String, dynamic> toMap() {
    return {
      'categoryImage': imageUrl,
      'categoryName': name,
      // 'categoryIcon': icon,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        imageUrl: map['categoryImage'] ?? '',
        name: map['categoryName'] ?? '',
        // icon: map['categoryIcon'] ?? 'icon',
        id: map['categoryId'] ?? ' ');
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
