import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/components/my_appbar.dart';
import 'package:app_force_sales/screens/dashboard.dart';
import 'package:app_force_sales/models/auth.dart';
import 'package:app_force_sales/models/profile.dart';
import 'package:app_force_sales/storage/user_storage.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final supabase = Supabase.instance.client;

  late bool passwordVisible;
  late Future<Auth> loginUser;

  final userStorage = UserStorage();

  final userName = TextEditingController();
  final passwordUser = TextEditingController();

  @override
  void dispose() {
    userName.dispose();
    passwordUser.dispose();

    super.dispose();
  }

  void toogle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: cuerpo(),
    );
  }

  Widget cuerpo() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          titulo(),
          const SizedBox(
            height: 20.0,
          ),
          email(),
          clave(),
          const SizedBox(
            height: 22.0,
          ),
          entrar(),
        ],
      ),
    );
  }

  Widget titulo() {
    return const Text(
      'Inicio de sesión',
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget email() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
      child: TextField(
        controller: userName,
        decoration: const InputDecoration(
          hintText: 'Escribe el nombre del usuario',
        ),
        autofocus: true,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget clave() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
      child: TextField(
        controller: passwordUser,
        decoration: InputDecoration(
          hintText: 'Escribe la contraseña',
          suffixIcon: IconButton(
            onPressed: () {
              toogle();
            },
            icon:
                Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
            color: Theme.of(context).primaryColor,
          ),
        ),
        obscureText: passwordVisible,
        style: const TextStyle(fontSize: 18.0),
      ),
    );
  }

  Widget entrar() {
    return ElevatedButton.icon(
      onPressed: () {
        loginUser = authUser();
        loginUser.then(
          (value) => {
            // ignore: avoid_print
            //print(value.accessToken)
            value.accessToken.isNotEmpty
                ? goDashboard(
                    value.id,
                    value.userName,
                    value.accessToken,
                    value.refreshToken,
                    value.email,
                    value.firstName,
                    value.lastName,
                  )
                : msgErrorLogin()
          },
        );
      },
      icon: const Icon(Icons.login_rounded),
      label: const Text(
        'Entrar',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  Future<Auth> authUser() async {
    // ignore: avoid_print
    //print('Credenciales: ${userName.text} ${passwordUser.text}');
    try {
      final response = await http.post(
        Uri.parse('https://dummyjson.com/auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'username': userName.text,
          'password': passwordUser.text,
          'expiresInMins': 30,
        }),
      );
      //debugPrint('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        return Auth.fromJson(jsonDecode(response.body));
      } else {
        return const Auth(
          id: '',
          userName: '',
          accessToken: '',
          refreshToken: '',
          email: '',
          firstName: '',
          lastName: '',
        );
      }
    } catch (ex) {
      return const Auth(
        id: '',
        userName: '',
        accessToken: '',
        refreshToken: '',
        email: '',
        firstName: '',
        lastName: '',
      );
    }
  }

  Future<List<Profile>> obtenerPerfil(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/auth/me'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
    );
    // ignore: avoid_print
    print(response.body);
    if (response.statusCode == 200) {
      List<Profile> profiles = [];

      final jsonData = jsonDecode(response.body);

      // ignore: avoid_print
      print(jsonData);

      for (var item in jsonData) {
        profiles.add(
          Profile(
            id: item['id'].toString(),
            firstName: item['firstName'],
            lastName: item['lastName'],
            email: item['email'],
            image: item['image'],
          ),
        );
      }

      return profiles;
    } else {
      return Future.error('Falló la conexión...');
    }
  }

  void goDashboard(
    String id,
    String userName,
    String accessToken,
    String refreshToken,
    String email,
    String firstName,
    String lastName,
  ) {
    GetInfoUser.of(context).setId(id);
    GetInfoUser.of(context).setAccessToken(accessToken);
    GetInfoUser.of(context).setRefreshToken(refreshToken);
    GetInfoUser.of(context).setEmail(email);
    GetInfoUser.of(context).setFullName(firstName, lastName);

    userStorage.writeUser(id, firstName, lastName, email);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Dashboard(),
      ),
    );
  }

  void msgErrorLogin() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aviso importante'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Credenciales no registradas'),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check_circle),
            label: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }
}
