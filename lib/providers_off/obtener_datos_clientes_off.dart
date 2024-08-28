import 'dart:convert';

import 'package:app_force_sales/models/cliente.dart';
import 'package:app_force_sales/storage/client_storage.dart';

final clientStorage = ClientStorage();

Future<List<Cliente>> obtenerClientesLocal() async {
  final response = await clientStorage.readClients();

  List<Cliente> clientes = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      clientes.add(
        Cliente(
          id: item['id'].toString(),
          phone: item['phone'],
          company: item['company'],
          address: item['address'],
        ),
      );
    }
  }

  return clientes;
}