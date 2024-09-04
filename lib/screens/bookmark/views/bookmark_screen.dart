import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/route/route_constants.dart';

import '../../../constants.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  final List<ProductModel2> _bookedProducts = [];

  @override
  void initState() {
    super.initState();
    // initialize _bookedProducts with an empty list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bookedProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/animations/Sad.json'),
                  const SizedBox(height: 20),
                  const Text(
                    'No bookmarked products found!',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200.0,
                      mainAxisSpacing: defaultPadding,
                      crossAxisSpacing: defaultPadding,
                      childAspectRatio: 0.66,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ProductCard(
                          image: _bookedProducts[index].image,
                          brandName: _bookedProducts[index].category,
                          title: _bookedProducts[index].title,
                          price: _bookedProducts[index].price,
                          priceAfetDiscount: _bookedProducts[index].price,
                          press: () {
                            Navigator.pushNamed(
                                context, productDetailsScreenRoute);
                          },
                        );
                      },
                      childCount: _bookedProducts.length,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
