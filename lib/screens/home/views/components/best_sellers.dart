import 'package:flutter/material.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/models/product_model_demo.dart';

import '../../../../components/skleton/product/products_skelton.dart';
import '../../../../constants.dart';
import '../../../../route/route_constants.dart';
import '../../../../services/get_all_product_service.dart';

class BestSellers extends StatelessWidget {
  const BestSellers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Best sellers",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // const ProductsSkelton(),
        FutureBuilder<List<ProductModel2>>(
            future: GetAllProductService().getAllProducts2(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ProductsSkelton();
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }

              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<ProductModel2> products = snapshot.data!;
                return SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                        left: defaultPadding,
                        right:
                            index == products.length - 1 ? defaultPadding : 0,
                      ),
                      child: products[index].rating!.rate > 4
                          ? ProductCard(
                              image: products[index].image,
                              brandName: products[index].category,
                              title: products[index].title,
                              price: demoBestSellersProducts[
                                      index % demoBestSellersProducts.length]
                                  .priceAfetDiscount,
                              priceAfetDiscount: products[index].price,
                              dicountpercent: demoFlashSaleProducts[
                                      index % demoFlashSaleProducts.length]
                                  .dicountpercent,
                              press: () {
                                Navigator.pushNamed(
                                    context, productDetailsScreenRoute,
                                    arguments: {
                                      'isProductAvailable': true,
                                      'product': products[index],
                                    });
                              },
                            )
                          : const SizedBox(),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("No products found"),
                );
              }
            })
      ],
    );
  }
}
