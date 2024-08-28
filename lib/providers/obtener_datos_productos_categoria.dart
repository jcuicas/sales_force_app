import 'dart:convert';

import 'package:app_force_sales/models/productos.dart';
import 'package:http/http.dart' as http;

Future<List<Producto>> obtenerProductosCategoria(String accessToken, String category) async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/products/category/$category'),
            headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
  );

  List<Producto> productos = [];

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);

    for (var item in jsonData['products']) {
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
    return productos;
  } else {
    return Future.error('Falló de conexión...');
  }
}
