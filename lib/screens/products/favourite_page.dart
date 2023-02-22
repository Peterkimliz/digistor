import 'package:digi_store/controllers/product_controller.dart';
import 'package:digi_store/models/product.dart';
import 'package:digi_store/screens/products/product_details.dart';
import 'package:digi_store/widgets/big_title.dart';
import 'package:digi_store/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritePage extends StatelessWidget {
  ProductController productController = Get.find<ProductController>();
  FavouritePage({Key? key}) : super(key: key) {
    productController.fetchUserfavouriteProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            "My Wishlist",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await productController.fetchUserfavouriteProduct();
          },
          child: Obx(
            () => productController.loadingFavProducts.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : productController.favProducts.length == 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Icon(
                              Icons.favorite,
                              color: Colors.green,
                              size: 60,
                            ),
                          ),
                          Center(
                            child: Text(
                              "No Favourites yet.",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                        physics: ScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                                itemCount: productController.favProducts.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  Product product = productController
                                      .favProducts
                                      .elementAt(index);
                                  return InkWell(
                                    onTap: () => Get.to(() => ProductDetails(
                                          product: product,
                                        )),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              width: 0.8)),
                                      margin: EdgeInsets.only(
                                          bottom: 5, right: 2, left: 2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 70,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    bottomLeft:
                                                        Radius.circular(8)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        product.images![0]))),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                bigTitle(
                                                    title: "${product.name}"
                                                        .capitalize!,
                                                    color: Colors.black),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                smallTitle(
                                                    title: "title erg",
                                                    color: Colors.grey),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "KSH ${product.price}",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                    Spacer(),
                                                    Icon(
                                                      Icons.shopping_cart,
                                                      size: 16,
                                                      color: Colors.green,
                                                    ),
                                                    SizedBox(width: 10),
                                                    InkWell(
                                                      onTap: () {
                                                        productController
                                                            .favouriteProduct(
                                                                product:
                                                                    product);
                                                        productController
                                                            .favProducts
                                                            .removeWhere(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    product.id);
                                                        productController
                                                            .favProducts
                                                            .refresh();
                                                      },
                                                      child: Icon(
                                                        Icons
                                                            .delete_forever_outlined,
                                                        size: 16,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
          ),
        ));
  }
}
