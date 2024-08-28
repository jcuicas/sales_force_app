import 'dart:convert';

import 'package:app_force_sales/models/user.dart';
import 'package:app_force_sales/storage/user_storage.dart';

final userStorage = UserStorage();

Future<List<User>> obtenerUsuarios() async {
  final response = await userStorage.readUser();

  List<User> usuarios = [];

  if (response.isNotEmpty) {
    final jsonData = jsonDecode(response);

    for (var item in jsonData) {
      usuarios.add(
        User(
          id: item['id'],
          firstName: item['firstName'],
          lastName: item['lastName'],
          email: item['email'],
        ),
      );
    }
  }

  return usuarios;
}
