import 'package:flutter/material.dart';
import 'package:shop/models/product_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../components/network_image_with_loader.dart';
import '../../constants.dart';
import '../../services/update_product_service.dart';
import '../product/views/components/product_images.dart';

class UpdateProductScreen extends StatefulWidget {
  UpdateProductScreen({
    super.key,
    required this.product,
  });

  ProductModel2 product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  bool isLoading = false;
  late String title;
  late String description;
  late String price;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Product'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Enter the new product details',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: NetworkImageWithLoader(widget.product.image,
                      fit: BoxFit.contain, radius: defaultBorderRadious),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  initialValue: widget.product.title,
                  maxLines: 2,
                  onChanged: (value) {
                    title = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.product.description,
                  onChanged: (value) {
                    description = value;
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Product Description',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: widget.product.price.toString(),
                  onChanged: (value) {
                    price = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    try {
                      isLoading = true;
                      setState(() {});
                      updateProduct();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product updated successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } catch (e) {
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(e.toString()),
                          backgroundColor: Colors.red,
                        ),
                      );
                      isLoading = false;
                      setState(() {});
                      print(e);
                    }
                  },
                  child: const Text('Update'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateProduct() {
    UpdateProductService().updateProduct(
        id: widget.product.id.toString(),
        title: title,
        description: description,
        price: price,
        category: widget.product.category,
        image: widget.product.image);
  }
}
