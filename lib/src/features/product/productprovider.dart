import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tgh_test/src/features/product/product_model.dart';
import 'package:tgh_test/src/features/product/productrepo.dart';

class Productprovider extends ChangeNotifier {
  bool? loginloading;
  bool? doorlogProgress;

  String? userName;
  Productrepo productrepo = Productrepo();
  ProductModel? productModel;
  List<ProductModel>? responseData;
  void startupadte() {
    loginloading = true;
    notifyListeners();
  }

  void stopupadte() {
    loginloading = false;
    notifyListeners();
  }

  void stopdoorlogProgress() {
    doorlogProgress = false;
    notifyListeners();
  }

  void stardoorlogProgress() {
    doorlogProgress = true;
    notifyListeners();
  }

  void productapi() async {
    try {
      startupadte();
      await Hive.initFlutter();
      final box = await Hive.openBox<ProductModel>(
          "af1af"); // Change box name to lowercase

      final response = await productrepo.productAPi();
      if (response == null) {
        return null;
      }
      log("Productrepo");
      if (response.statusCode == 200) {
        responseData = (response.data as List<dynamic>).map((dynamic item) {
          return ProductModel.fromJson(item);
        }).toList();

        // Clear and addAll to update the existing box with new data
        box.clear();
        box.addAll(responseData!);

        log("Data updated from API");
        stopupadte();
      }

      // Whether there is internet or not, load data from Hive
      if (box.isNotEmpty) {
        log("Data loaded from Hive");
        // If there is data in Hive, use it
        productModel = box.values.first;
        stopupadte();
      } else {
        log("No data in Hive");
        stopupadte();

        // Handle the case where there is no internet and no data in Hive
        // Display a message or take other actions.
      }
    } catch (e) {
      log(e.toString());
      log("Error occurred");
      stopupadte();
    }

    notifyListeners();
  }

  @override
  notifyListeners();
}
