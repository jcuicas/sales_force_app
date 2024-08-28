// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:app_force_sales/models/cliente.dart';
import 'package:http/http.dart' as http;

Future<List<Cliente>> obtenerClientes(String accessToken) async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/users'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    },
  );

  List<Cliente> clientes = [];

  if (response.statusCode == 200) {
    //print(response.body);
    final jsonData = jsonDecode(response.body);
    //print(jsonData['users']);
    for (var item in jsonData['users']) {
      //print(item['id']);
      //print(item['phone']);
      //print(item['company']['name']);
      //print(item['address']['address']);
      clientes.add(
        Cliente(
          id: item['id'].toString(),
          phone: item['phone'],
          company: item['company']['name'],
          address: item['address']['address'],
        ),
      );
    }

    return clientes;
  } else {
    return Future.error('Falló de conexión...');
  }
}
