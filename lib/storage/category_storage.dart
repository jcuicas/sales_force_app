import 'dart:convert';
import 'dart:io';

import 'package:app_force_sales/models/categorias.dart';
import 'package:path_provider/path_provider.dart';

class CategoryStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/categories.json');
  }

  Future<String> readCategories() async {
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

  Future<File> writeCategories(List<Categoria> categorias) async {
    final file = await _localFile;

    final String jsonCategories = jsonEncode(categorias);

    //Escribir archivo
    return file.writeAsString(jsonCategories);
  }
}
