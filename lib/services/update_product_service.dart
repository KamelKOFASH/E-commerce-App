import 'package:shop/models/product_model.dart';

import '../helper/api.dart';

class UpdateProductService {
  Future<ProductModel2> updateProduct({
    required dynamic id,
    required String title,
    required String description,
    required String price,
    required String category,
    required String image,
  }) async {
    Map<String, dynamic> data = await Api().put(
      url: "https://fakestoreapi.com/products/$id",
      body: {
        'title': title,
        'price': price,
        'description': description,
        'image': image,
        'category': category,
      }, token: '',
    );
    return ProductModel2.fromJson(data);
  }
}
