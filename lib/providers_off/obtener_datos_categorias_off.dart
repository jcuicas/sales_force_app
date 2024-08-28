import 'dart:convert';

import 'package:app_force_sales/models/categorias.dart';
import 'package:app_force_sales/storage/category_storage.dart';

final categoryStorage = CategoryStorage();

Future<List<Categoria>> obtenerCategoriasLocal() async {
  final response = await categoryStorage.readCategories();

  List<Categoria> categorias = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      categorias.add(
        Categoria(
          slug: item['slug'],
          name: item['name'],
          url: item['url'],
        ),
      );
    }
  }

  return categorias;
}