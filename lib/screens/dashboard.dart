import 'package:flutter/material.dart';
import 'package:app_force_sales/models/user.dart';
import 'package:app_force_sales/storage/user_storage.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/components/my_appbar.dart';
import 'package:app_force_sales/components/my_button_drawer.dart';
import 'package:app_force_sales/components/my_drawer.dart';
import 'package:app_force_sales/providers_off/obtener_datos_user_off.dart';
import 'package:app_force_sales/screens/categorias.dart';
import 'package:app_force_sales/screens/clientes.dart';
import 'package:app_force_sales/screens/existencias.dart';
import 'package:app_force_sales/screens/historico_pedidos.dart';
import 'package:app_force_sales/screens/orden_pedidos.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<User>>? listUsers;

  final userStorage = UserStorage();

  @override
  Widget build(BuildContext context) {
    if (GetInfoUser.of(context).conexion! == false) {
      getInfoUserOffline();
    }
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: MyAppBar(
        myButtonDrawer: MyButtonDrawer(
          scaffoldKey: _scaffoldKey,
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 3.0),
            child: Card(
              color: const Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: const Text(
                  'Categorias',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/categorias2.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListadoCategorias(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 3.0),
            child: Card(
              color: const Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: const Text(
                  'Historico de pedidos',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/pedidos2.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoricoPedidios(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 3.0),
            child: Card(
              color: const Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: const Text(
                  'Clientes',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/clientes2.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListadoClientes(),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0, right: 3.0),
            child: Card(
              color: Color(0xffffffff),
              elevation: 3.0,
              child: ListTile(
                title: Text(
                  'Existencias',
                  textAlign: TextAlign.center,
                ),
                subtitle: Image.asset('assets/img/existencias2.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListadoExistencias(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrdenPedido(),
            ),
          );
        },
        label: const Text(
          'Pedidos',
          style: TextStyle(
            color: Color(0xffffffff),
          ),
        ),
        icon: const Icon(
          Icons.thumb_up_alt,
          color: Color(0xffffffff),
        ),
        backgroundColor: const Color(0xffec1c24),
      ),
    );
  }

  void getInfoUserOffline() {
    listUsers = obtenerUsuarios();

    listUsers!.then(
      (value) => {
        for (var item in value)
          {
            GetInfoUser.of(context).setId(item.id),
            GetInfoUser.of(context).setFullName(item.firstName, item.lastName),
            GetInfoUser.of(context).setEmail(item.email),
          }
      },
    );
  }
}
