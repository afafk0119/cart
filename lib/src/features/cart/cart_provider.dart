import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tgh_test/src/features/cart/cart_model.dart';

class Cartprovider extends ChangeNotifier {
  void cartorder(
      String itemName, int quantity, int id, double price, String image) async {
    final box = Hive.box<AddItemModel>('addedItems');

    if (quantity == 0) {
      // If the quantity is zero, delete from the cart
      box.delete(itemName);
    } else {
      // If the quantity is not zero, add/update in the cart
      final addedItem = AddItemModel(
        id: id,
        name: itemName,
        price: price,
        quantity: quantity,
        image: image,
      );
      box.put(addedItem.name, addedItem);
    }
    notifyListeners();
  }

  @override
  notifyListeners();
}
