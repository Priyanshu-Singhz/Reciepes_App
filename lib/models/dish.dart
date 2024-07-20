class Dish {
  final String dishName;
  final String dishId;
  final String imageUrl;
  final bool isPublished;

  Dish({
    required this.dishName,
    required this.dishId,
    required this.imageUrl,
    required this.isPublished,
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      dishName: json['dishName'],
      dishId: json['dishId'],
      imageUrl: json['imageUrl'],
      isPublished: json['isPublished'],
    );
  }
}
