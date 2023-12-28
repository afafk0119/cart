// product_actions_model.dart

import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 2)
class AddItemModel extends HiveObject {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late double price;

  @HiveField(3)
  late int quantity;
  @HiveField(4)
  late String image;
  AddItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });
}

@HiveType(typeId: 3)
class RemoveItemModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double price;

  @HiveField(2)
  late int quantity;
  @HiveField(3)
  late String image;
  RemoveItemModel({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });
}

@HiveType(typeId: 4)
class DisplayItemModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double price;

  @HiveField(2)
  late int quantity;
  @HiveField(3)
  late String image;

  DisplayItemModel({
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });
}
