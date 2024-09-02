import 'package:shop/models/product_model_demo.dart';

import '../helper/api.dart';

class UpdateProductService {
  Future<ProductModel> updateProduct({
    required String id,
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
      },
    );
    return ProductModel.fromJson(data);
  }
}
