import 'package:flutter/material.dart';

class Product {
  final String? image, name, unit, parentName, details, sellerDetails;
  final int? id, parentId;
  int? quantity = 0;
  final double? price;
  final Color? color;
  Product({
    this.id,
    this.name,
    this.image,
    this.parentId,
    this.parentName,
    this.price,
    this.unit,
    this.details,
    this.sellerDetails,
    this.quantity,
    this.color,
  });
}
