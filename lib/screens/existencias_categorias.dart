import 'package:flutter/material.dart';
import 'package:app_force_sales/models/productos.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/components/my_appbar.dart';
import 'package:app_force_sales/components/my_button_drawer.dart';
import 'package:app_force_sales/components/my_drawer.dart';
import 'package:app_force_sales/delegates/buscar_existencias.dart';
import 'package:app_force_sales/providers/obtener_datos_productos_categoria.dart';
import 'package:app_force_sales/providers_off/obtener_datos_productos_categoria_off.dart';
import 'package:app_force_sales/storage/product_category_storage.dart';

class ListadoExistenciasCategoria extends StatefulWidget {
  final String category;

  const ListadoExistenciasCategoria({
    super.key,
    required this.category,
  });

  @override
  State<ListadoExistenciasCategoria> createState() =>
      _ListadoExistenciasCategoriaState();
}

class _ListadoExistenciasCategoriaState
    extends State<ListadoExistenciasCategoria> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Producto>> listaProductosCategoria;

  final productStorageCategory = ProductCategoryStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaProductosCategoria = obtenerProductosCategoria(
          GetInfoUser.of(context).accessToken.toString(), widget.category);
    } else {
      listaProductosCategoria = obtenerProductosCategoriaLocal(widget.category);
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
        future: listaProductosCategoria,
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
            'Listado de productos',
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
          subtitle: Text('Price: ${item.price} usd - ${widget.category}'),
          trailing: Text('${item.stock} stok'),
        ),
      ));
    }

    productStorageCategory.writeProductsCategory(datos, widget.category.toString());

    return existencias;
  }
}
