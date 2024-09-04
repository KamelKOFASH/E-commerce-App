import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:shop/components/buy_full_ui_kit.dart';
import 'package:shop/components/cart_button.dart';
import 'package:shop/components/custom_modal_bottom_sheet.dart';
import 'package:shop/components/product/product_card.dart';
import 'package:shop/constants.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/screens/product/views/product_returns_screen.dart';

import 'package:shop/route/screen_export.dart';
import 'package:shop/services/get_category_by_name.dart';

import '../../../components/skleton/product/products_skelton.dart';
import '../../../models/product_model_demo.dart';
import 'components/notify_me_card.dart';
import 'components/product_images.dart';
import 'components/product_info.dart';
import 'components/product_list_tile.dart';
import '../../../components/review_card.dart';
import 'product_buy_now_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen(
      {super.key, this.isProductAvailable = true, required this.product});

  final bool isProductAvailable;
  final ProductModel2 product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.isProductAvailable
          ? CartButton(
              price: widget.product.price,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: ProductBuyNowScreen(
                    product: widget.product,
                  ),
                );
              },
            )
          :
          //* If profuct is not available then show [NotifyMeCard]
          NotifyMeCard(
              isNotify: false,
              onChanged: (value) {},
            ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              floating: true,
              actions: [
                IconButton(
                  icon: Icon(widget.product.bookmark == true
                      ? Icons.bookmark
                      : Icons.bookmark_border),
                  onPressed: () {
                    setState(() {
                      widget.product.bookmark = widget.product.bookmark != null
                          ? !widget.product.bookmark!
                          : true;
                    });
                  },
                ),
              ],
            ),
            ProductImages(
              images: [
                widget.product.image,
                widget.product.image,
                widget.product.image
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Edit Product'),
                    IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            updateProductScreenRoute,
                            arguments: {'product': widget.product},
                          );
                        },
                        icon: const Icon(
                          size: 18,
                          FontAwesomeIcons.edit,
                          color: Colors.black,
                        )),
                  ],
                ),
              ),
            ),
            ProductInfo(
              brand: widget.product.category,
              title: widget.product.title,
              isAvailable: widget.isProductAvailable,
              description: widget.product.description,
              rating: widget.product.rating!.rate,
              numOfReviews: widget.product.rating!.count,
            ),
            ProductListTile(
              svgSrc: "assets/icons/Product.svg",
              title: "Product Details",
              press: () {
                // customModalBottomSheet(
                //   context,
                //   height: MediaQuery.of(context).size.height * 0.92,
                //   child: const BuyFullKit(
                //       images: ["assets/screens/Product detail.png"]),
                // );
              },
            ),
            ProductListTile(
              svgSrc: "assets/icons/Delivery.svg",
              title: "Shipping Information",
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const BuyFullKit(
                    images: ["assets/screens/Shipping information.png"],
                  ),
                );
              },
            ),
            ProductListTile(
              svgSrc: "assets/icons/Return.svg",
              title: "Returns",
              isShowBottomBorder: true,
              press: () {
                customModalBottomSheet(
                  context,
                  height: MediaQuery.of(context).size.height * 0.92,
                  child: const ProductReturnsScreen(),
                );
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ReviewCard(
                  rating: widget.product.rating!.rate,
                  numOfReviews: widget.product.rating!.count,
                  numOfFiveStar: 80,
                  numOfFourStar: 30,
                  numOfThreeStar: 5,
                  numOfTwoStar: 4,
                  numOfOneStar: 1,
                ),
              ),
            ),
            ProductListTile(
              svgSrc: "assets/icons/Chat.svg",
              title: "Reviews",
              isShowBottomBorder: true,
              press: () {
                Navigator.pushNamed(context, productReviewsScreenRoute);
              },
            ),
            SliverPadding(
              padding: const EdgeInsets.all(defaultPadding),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "You may also like",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: FutureBuilder<List<ProductModel2>>(
                future: GetCategoryByNameService()
                    .getCategoryByName(widget.product.category),
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
                              right: index == products.length - 1
                                  ? defaultPadding
                                  : 0),
                          child: ProductCard(
                            image: products[index].image,
                            title: products[index].title,
                            brandName: products[index].category,
                            price: demoBestSellersProducts[
                                    index % demoBestSellersProducts.length]
                                .priceAfetDiscount,
                            priceAfetDiscount: products[index].price,
                            dicountpercent: demoFlashSaleProducts[
                                    index % demoFlashSaleProducts.length]
                                .dicountpercent,
                            press: () {
                              Navigator.pushNamed(
                                context,
                                productDetailsScreenRoute,
                                arguments: {
                                  'isProductAvailable': true,
                                  'product': products[index],
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No products available"),
                    );
                  }
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: defaultPadding),
            )
          ],
        ),
      ),
    );
  }
}
