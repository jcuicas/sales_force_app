import 'dart:convert';

import 'package:app_force_sales/models/productos.dart';
import 'package:app_force_sales/storage/product_storage.dart';

final productStorage = ProductStorage();

Future<List<Producto>> obtenerProductosLocal() async {
  final response = await productStorage.readProducts();

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