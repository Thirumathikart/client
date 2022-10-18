import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:thirumathikart_app/config/themes.dart';
import 'package:thirumathikart_app/constants/navigation_routes.dart';
import 'package:thirumathikart_app/controllers/products_controller.dart';
import 'package:get/get.dart';
import 'package:thirumathikart_app/widgets/app_bar.dart';

class Products extends GetView<ProductsController> {
  const Products({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsController = Get.find<ProductsController>();
    final productsListMain = Get.arguments[0];
    final title = Get.arguments[1];
    controller.getProductsByCategory(title, true);
    final FocusNode focusNode = FocusNode();
    if (productsController.flag.value) {
      productsController.copy(productsListMain);
      productsController.switchFlag();
    }
    return Scaffold(
      appBar: appBar(productsListMain[0].parentName!),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: AppTheme.searchBar,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Search : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 175,
                    child: TextField(
                      controller: productsController.textController,
                      showCursor: true,
                      cursorHeight: 25,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      focusNode: focusNode,
                      onChanged: (_) {
                        productsController.empty();
                        for (int i = 0; i < productsListMain.length; i++) {
                          if (productsListMain[i].name!.toLowerCase().contains(
                              productsController.textController.text)) {
                            productsController.add(
                                productsController.productsListDynamic.toList(),
                                productsListMain[i]);
                          }
                        }
                        if (productsController.isSelected[0] == false &&
                            productsController.isSelected[1] == true) {
                          productsController.reverse();
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 4,
                    ),
                    child: IconButton(
                      onPressed: focusNode.requestFocus,
                      icon: const Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sort by Price : ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Obx(
                        () => ToggleButtons(
                          borderColor: AppTheme.selected,
                          fillColor: AppTheme.unSelected,
                          borderWidth: 2,
                          selectedBorderColor: AppTheme.selected,
                          selectedColor: AppTheme.textSecondary,
                          borderRadius: BorderRadius.circular(50),
                          onPressed: (int index) {
                            if (index == 0) {
                              controller.getProductsByCategory(title, true);
                              controller.set(0, true);
                            } else {
                              controller.getProductsByCategory(title, false);
                              controller.set(1, false);
                            }
                            for (int i = 0;
                                i < controller.isSelected.length;
                                i++) {
                              controller.set(i, i == index);
                            }
                          },
                          isSelected: controller.isSelected,
                          children: const <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                'Low - High',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                'High - Low',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: controller.obx(
            (state) => GridView.builder(
              itemCount: state!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (ctx, index) => GestureDetector(
                onTap: () {
                  Get.toNamed(NavigationRoutes.productDetailRoute, arguments: [
                    productsController.productsListDynamic[index],
                    productsListMain
                  ]);
                },
                child: Container(
                    height: 300,
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(children: [
                      Expanded(
                          flex: 1,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0)),
                              child: CachedNetworkImage(
                                width: double.infinity,
                                fit: BoxFit.fill,
                                imageUrl: state[index].productPhoto!,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ))),
                      Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(children: [
                            Text(
                              state[index].productTitle!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '₹ ${state[index].productPrice}/kg',
                              style: const TextStyle(
                                fontSize: 8,
                              ),
                            )
                          ])),
                    ])),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
