// To parse this JSON data, do
//
//     final createOrderRequest = createOrderRequestFromJson(jsonString);

import 'dart:convert';

OrderRequest createOrderRequestFromJson(String str) =>
    OrderRequest.fromJson(json.decode(str));

String createOrderRequestToJson(OrderRequest data) =>
    json.encode(data.toJson());

class OrderRequest {
  OrderRequest({
    this.orderItems,
    this.sellerContact,
  });

  List<OrderItem>? orderItems;
  String? sellerContact;

  factory OrderRequest.fromJson(Map<String, dynamic> json) => OrderRequest(
        orderItems:
            List<OrderItem>.from(json['order_items'].map(OrderItem.fromJson)),
        sellerContact: json['seller_contact'],
      );

  Map<String, dynamic> toJson() => {
        'order_items': List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        'seller_contact': sellerContact,
      };
}

class OrderItem {
  OrderItem({
    this.productId,
    this.productQuantity,
  });

  int? productId;
  int? productQuantity;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json['product_id'],
        productQuantity: json['product_quantity'],
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_quantity': productQuantity,
      };
}
