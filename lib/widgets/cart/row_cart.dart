import 'package:flutter/material.dart';
import 'package:thirumathikart_app/controllers/cart_controller.dart';
import 'package:thirumathikart_app/models/product.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RowCart extends StatelessWidget {
  static late CartController controller;
  final int index;

  final Product product;
  const RowCart({
    Key? key,
    required this.index,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller = Get.find<CartController>();

    return Container(
      height: 120.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(product.image!),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${product.name}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "₹ ${NumberFormat.currency(decimalDigits: 0, symbol: '').format(product.price)}",
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Total - ₹ ${NumberFormat.currency(decimalDigits: 0, symbol: '').format(product.price! * product.quantity!)}",
                ),
                Expanded(child: _buildQty()),
              ],
            ),
          ),
          SizedBox(
            width: 30.0,
            child: TextButton(
              child: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: () => controller.removeSelectedItemFromCart(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQty() => Row(
        children: [
          Row(
            children: [
              const Text(
                'qty: ',
                style: TextStyle(fontSize: 12),
              ),
              IconButton(
                onPressed: () =>
                    controller.decreaseQtyOfSelectedItemInCart(index, product),
                icon: const Icon(
                  Icons.remove,
                  size: 12,
                ),
              ),
              Text(product.quantity.toString()),
              IconButton(
                onPressed: () =>
                    controller.increaseQtyOfSelectedItemInCart(index),
                icon: const Icon(
                  Icons.add,
                  size: 12,
                ),
              ),
            ],
          )
        ],
      );
}
