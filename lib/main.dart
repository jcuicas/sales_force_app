import 'package:flutter/material.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/screens/home.dart';

void main() => runApp(const MyAppForceSales());

class MyAppForceSales extends StatelessWidget {
  const MyAppForceSales({super.key});

  @override
  Widget build(BuildContext context) {
    const String tituloApp = 'Sales Force App';

    return GetInfoUser(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: tituloApp,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        ),
        home: HomeScreen(
          titulo: tituloApp,
        ),
      ),
    );
  }
}
