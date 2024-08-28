import 'dart:convert';
import 'dart:io';

import 'package:app_force_sales/models/productos.dart';
import 'package:path_provider/path_provider.dart';

class ProductStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/products.json');
  }

  Future<String> readProducts() async {
    try {
      final file = await _localFile;

      //Leer archivo
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      //Si encuentra un error, retorna cadena vacia
      return '';
    }
  }

  Future<File> writeProducts(List<Producto> productos) async {
    final file = await _localFile;

    final String jsonProducts = jsonEncode(productos);

    //Escribir archivo
    return file.writeAsString(jsonProducts);
  }
}
