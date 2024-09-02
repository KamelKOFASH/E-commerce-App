import '../helper/api.dart';
import '../models/product_model_demo.dart';

class AddProductService {
  Future<ProductModel> addProduct(
      {required String title,
      required String description,
      required String price,
      required String category,
      required String image}) async {
    Map<String, dynamic> data = await Api().post(
      url: "https://fakestoreapi.com/products",
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
