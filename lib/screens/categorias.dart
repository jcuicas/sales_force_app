import 'package:app_force_sales/screens/existencias_categorias.dart';
import 'package:flutter/material.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/providers/obtener_datos_categorias.dart';
import 'package:app_force_sales/providers_off/obtener_datos_categorias_off.dart';
import 'package:app_force_sales/models/categorias.dart';
import 'package:app_force_sales/storage/category_storage.dart';
import 'package:app_force_sales/components/my_appbar.dart';
import 'package:app_force_sales/components/my_button_drawer.dart';
import 'package:app_force_sales/components/my_drawer.dart';
import 'package:app_force_sales/delegates/buscar_categorias.dart';

class ListadoCategorias extends StatefulWidget {
  const ListadoCategorias({super.key});

  @override
  State<ListadoCategorias> createState() => _ListadoCategoriasState();
}

class _ListadoCategoriasState extends State<ListadoCategorias> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Categoria>> listaCategorias;

  final categoryStorage = CategoryStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaCategorias =
          obtenerCategorias(GetInfoUser.of(context).accessToken.toString());
    } else {
      listaCategorias = obtenerCategoriasLocal();
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
          future: listaCategorias,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: verCategorias(snapshot.data!),
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
        ));
  }

  List<Widget> verCategorias(List<Categoria> datos) {
    List<Widget> categorias = [];

    categorias.add(Card(
      child: ListTile(
        title: const Text(
          'Lista de categorias',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: BuscarCategoria(listaCategorias: datos),
            );
          },
          icon: const Icon(Icons.search),
        ),
      ),
    ));
    for (var item in datos) {
      categorias.add(
        Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                item.name.substring(0, 2),
              ),
            ),
            title: Text(item.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListadoExistenciasCategoria(category: item.slug),
                ),
              );
            },
          ),
        ),
      );
    }

    categoryStorage.writeCategories(datos);

    return categorias;
  }
}
