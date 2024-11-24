class Book {
  final int id;
  final String name;
  final String author;
  final String cover;
  final String description;
  final double price;
  final int sales;
  final String slug;
  final int likes;
  final DateTime createdAt;

  Book({
    required this.id,
    required this.name,
    required this.author,
    required this.cover,
    required this.description,
    required this.price,
    required this.sales,
    required this.slug,
    required this.likes,
    required this.createdAt,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json["id"],
      name: json["name"],
      author: json["author"],
      cover: json["cover"],
      description: json["description"],
      price: (json["price"] as num).toDouble(),
      sales: json["sales"],
      slug: json["slug"],
      likes: json["likes_aggregate"]["aggregate"]["count"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "author": author,
      "cover": cover,
      "description": description,
      "price": price,
      "sales": sales,
      "slug": slug,
      "likes_aggregate": {
        "aggregate": {"count": likes},
      },
      "created_at": createdAt.toIso8601String(),
    };
  }
}
