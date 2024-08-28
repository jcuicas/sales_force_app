import 'package:flutter/material.dart';
import 'package:app_force_sales/models/productos.dart';
import 'package:app_force_sales/storage/product_storage.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/providers/obtener_datos_productos.dart';
import 'package:app_force_sales/providers_off/obtener_datos_productos_off.dart';
import 'package:app_force_sales/components/my_appbar.dart';
import 'package:app_force_sales/components/my_button_drawer.dart';
import 'package:app_force_sales/components/my_drawer.dart';
import 'package:app_force_sales/delegates/buscar_existencias.dart';

class ListadoExistencias extends StatefulWidget {
  const ListadoExistencias({super.key});

  @override
  State<ListadoExistencias> createState() => _ListadoExistenciasState();
}

class _ListadoExistenciasState extends State<ListadoExistencias> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Producto>> listaProductos;

  final productStorage = ProductStorage();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaProductos = obtenerProductos(GetInfoUser.of(context).accessToken.toString());
    } else {
      listaProductos = obtenerProductosLocal();
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scaffoldKey: _scaffoldKey,
        ),
      ),
      body: FutureBuilder(
        future: listaProductos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verExistencias(snapshot.data!),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('No hay datos...'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  List<Widget> verExistencias(List<Producto> datos) {
    List<Widget> existencias = [];

    existencias.add(
      Card(
        child: ListTile(
          leading: const Text(
            'Lista de productos',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          trailing: IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: BuscarExistencia(listaProductos: datos));
              },
              icon: const Icon(Icons.search)),
        ),
      ),
    );

    for (var item in datos) {
      existencias.add(Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              item.title.substring(0, 2),
            ),
          ),
          title: Text(item.title),
          subtitle: Text('Price: ${item.price} usd'),
          trailing: Text('${item.stock} stok'),
        ),
      ));
    }

    productStorage.writeProducts(datos);

    return existencias;
  }
}
