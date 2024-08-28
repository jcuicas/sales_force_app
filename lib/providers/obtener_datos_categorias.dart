import 'dart:convert';

import 'package:app_force_sales/models/categorias.dart';
import 'package:http/http.dart' as http;

Future<List<Categoria>> obtenerCategorias(String accessToken) async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products/categories'),
        headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
  );

  List<Categoria> categorias = [];

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    
    for (var item in jsonData) {
      categorias.add(
        Categoria(
          slug: item['slug'],
          name: item['name'],
          url: item['url'],
        ),
      );
    }

    return categorias;
  } else {
    return Future.error('Falló de conexión...');
  }
}
