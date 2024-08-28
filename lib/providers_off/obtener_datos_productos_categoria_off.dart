import 'dart:convert';

import 'package:app_force_sales/models/productos.dart';
import 'package:app_force_sales/storage/product_category_storage.dart';

final productCategoryStorage = ProductCategoryStorage();

Future<List<Producto>> obtenerProductosCategoriaLocal(String category) async {
  final response = await productCategoryStorage.readProductsCategory(category);

  List<Producto> productos = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      productos.add(
        Producto(
          id: item['id'].toString(),
          title: item['title'],
          category: item['category'],
          price: item['price'].toString(),
          stock: item['stock'].toString(),
        ),
      );
    }
  }

  return productos;
}