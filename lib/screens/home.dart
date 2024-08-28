import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/screens/login.dart';
import 'package:app_force_sales/screens/dashboard.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as developer;

class HomeScreen extends StatefulWidget {
  final String titulo;

  const HomeScreen({
    super.key,
    required this.titulo,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();

    super.dispose();
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    //print('Connectivity changed: $_connectionStatus');
  }

  @override
  Widget build(BuildContext context) {

    bool conexion = _connectionStatus[0].toString() == ConnectivityResult.wifi.toString();

    GetInfoUser.of(context).setConexion(conexion);
    GetInfoUser.of(context).setAppTitle(widget.titulo);

    return Scaffold(
      body: conexion ? Login() : Dashboard(),
      backgroundColor: Colors.grey[200],
    );
  }
}
