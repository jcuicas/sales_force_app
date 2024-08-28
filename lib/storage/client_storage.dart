import 'dart:convert';
import 'dart:io';

import 'package:app_force_sales/models/cliente.dart';
import 'package:path_provider/path_provider.dart';

class ClientStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/clients.json');
  }

  Future<String> readClients() async {
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

  Future<File> writeClients(List<Cliente> clientes) async {
    final file = await _localFile;

    final String jsonClient = jsonEncode(clientes);

    //Escribir archivo
    return file.writeAsString(jsonClient);
  }
}
