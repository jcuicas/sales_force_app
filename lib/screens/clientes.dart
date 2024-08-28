import 'package:flutter/material.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/providers/obtener_datos_clientes.dart';
import 'package:app_force_sales/providers_off/obtener_datos_clientes_off.dart';
import 'package:app_force_sales/storage/client_storage.dart';
import 'package:app_force_sales/models/cliente.dart';
import 'package:app_force_sales/components/my_appbar.dart';
import 'package:app_force_sales/components/my_button_drawer.dart';
import 'package:app_force_sales/components/my_drawer.dart';
import 'package:app_force_sales/delegates/buscar_clientes.dart';

class ListadoClientes extends StatefulWidget {
  const ListadoClientes({
    super.key,
  });

  @override
  State<ListadoClientes> createState() => _ListadoClientesState();
}

class _ListadoClientesState extends State<ListadoClientes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final Future<List<Cliente>> listaClientes;

  final clientStorage = ClientStorage();

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion!) {
      listaClientes = obtenerClientes(GetInfoUser.of(context).accessToken.toString());
    } else {
      listaClientes = obtenerClientesLocal();
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
        future: listaClientes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: verCLientes(snapshot.data!),
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

  List<Widget> verCLientes(List<Cliente> datos) {
    List<Widget> clientes = [];

    clientes.add(
      Card(
        child: ListTile(
          title: const Text(
            'Lista de clientes',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: BuscarCliente(listaClientes: datos),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ),
      ),
    );

    for (var item in datos) {
      clientes.add(Card(
        child: ListTile(
          leading: CircleAvatar(
            child: Text(
              item.company.substring(0, 2),
            ),
          ),
          title: Text(item.company),
          subtitle: Text(item.address),
          trailing: Text(item.phone),
        ),
      ));
    }

    clientStorage.writeClients(datos);

    return clientes;
  }
}
