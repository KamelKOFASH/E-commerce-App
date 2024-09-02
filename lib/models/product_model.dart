class ProductModel2 {
  final dynamic id;
  final String title;
  final dynamic price;
  final String description;
  final String image;
  final RatingModel2? rating;
  final String category;
  ProductModel2(
      {required this.id,
      required this.title,
      required this.category,
      required this.price,
      required this.description,
      required this.image,
      required this.rating});

  factory ProductModel2.fromJson(jsonData) {
    return ProductModel2(
        id:jsonData['id'],
        title: jsonData['title'],
        category: jsonData['category'],
        price: jsonData['price'],
        description: jsonData['description'],
        image: jsonData['image'],
        rating: jsonData['rating'] == null
            ? null
            : RatingModel2.fromJson(jsonData['rating']));
  }
}

class RatingModel2 {
  final dynamic rate;
  final int count;

  RatingModel2({required this.rate, required this.count});

  factory RatingModel2.fromJson(jsonData) {
    return RatingModel2(rate: jsonData['rate'], count: jsonData['count']);
  }
}
