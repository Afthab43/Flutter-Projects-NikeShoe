import 'package:brand_app/components/custom_snackbars.dart';
import 'package:brand_app/data/dummy.dart';
import 'package:brand_app/model/shoe.model.dart';
import 'package:flutter/material.dart';

class AppMethods {
  AppMethods._();

  // this function is used to add products to the cart
  static void addToCart(ShoeModel data, BuildContext context) {
    //if contains is true, we have that item already in the cart orelse we add it to the cart
    bool contains = itemsOnCart.contains(data);
    if (contains) {
      // item present in the cart
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(CustomSnackbars.failedSnackbar());
    } else {
      // item not present in the cart
      itemsOnCart.add(data);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(CustomSnackbars.successSnackbar());
    }
  }

  static double allTheItemsOnCart() {
    double totalAmount = 0.0;
    for (ShoeModel item in itemsOnCart) {
      totalAmount += item.price;
    }
    return totalAmount;
  }
}
