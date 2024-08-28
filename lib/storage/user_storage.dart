import 'dart:convert';
import 'dart:io';

import 'package:app_force_sales/models/user.dart';
import 'package:path_provider/path_provider.dart';

class UserStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    return File('$path/user.json');
  }

  Future<String> readUser() async {
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

  Future<File> writeUser(String id, String firstName, String lastName, String userEmail) async {
    final file = await _localFile;

    final user = User(id: id, firstName: firstName, lastName: lastName, email: userEmail);

    final String jsonUser = jsonEncode([user]);

    //Escribir archivo
    return file.writeAsString(jsonUser);
  }
}
