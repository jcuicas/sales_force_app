import 'dart:convert';
import 'dart:io';

import 'package:app_force_sales/models/productos.dart';
import 'package:path_provider/path_provider.dart';

class ProductCategoryStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> _localFile(String category) async {
    final path = await _localPath;

    return File('$path/products_$category.json');
  }

  Future<String> readProductsCategory(String category) async {
    try {
      final file = await _localFile(category);

      //Leer archivo
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      //Si encuentra un error, retorna cadena vacia
      return '';
    }
  }

  Future<File> writeProductsCategory(List<Producto> productos, String category) async {
    final file = await _localFile(category);

    final String jsonProducts = jsonEncode(productos);

    //Escribir archivo
    return file.writeAsString(jsonProducts);
  }
}
