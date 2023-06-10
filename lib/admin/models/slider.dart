import 'dart:convert';

class Slider {
  String? id;
  String? imageUrl;
  String? title;
  // String? url;
  Slider({
    this.imageUrl,
    this.title,
    // this.url,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      // 'url': url,
    };
  }

  factory Slider.fromMap(Map<String, dynamic> map) {
    return Slider(
      imageUrl: map['imageUrl'],
      title: map['title'],
      // url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Slider.fromJson(String source) => Slider.fromMap(json.decode(source));
}
