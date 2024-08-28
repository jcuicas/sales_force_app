import 'package:flutter/material.dart';
import 'package:app_force_sales/inherited/my_inherited.dart';
import 'package:app_force_sales/components/my_user_account.dart';
import 'package:app_force_sales/screens/dashboard.dart';
import 'package:app_force_sales/screens/categorias.dart';
import 'package:app_force_sales/screens/clientes.dart';
import 'package:app_force_sales/screens/existencias.dart';
import 'package:app_force_sales/screens/historico_pedidos.dart';
import 'package:app_force_sales/screens/orden_pedidos.dart';
import 'package:app_force_sales/screens/ver_pedidos.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({
    super.key,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                MyUserAccount(
                  userEmail: GetInfoUser.of(context).userEmail!,
                  fullName: GetInfoUser.of(context).fullName!,
                ),
                ListTile(
                  leading: Image.asset('assets/img/dashboard2.png'),
                  title: const Text('Inicio'),
                  trailing: const Icon(
                    Icons.home,
                    color: Color(0xffec1c24),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Dashboard(),
                      ),
                    );
                  },
                ),
                Divider(
                  color: Color(0xffec1c24),
                ),
                ListTile(
                  leading: Image.asset('assets/img/categorias2.png'),
                  title: const Text('Categorias'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoCategorias(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/pedidos2.png'),
                  title: const Text('Historico de pedidos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HistoricoPedidios(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/clientes2.png'),
                  title: const Text('Clientes'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoClientes(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/existencias2.png'),
                  title: const Text('Existencias'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListadoExistencias(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/order2.png'),
                  title: const Text('Orden de pedido'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdenPedido(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Image.asset('assets/img/carrito2.png'),
                  title: const Text('Carrito de pedidos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VerPedidos(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffec1c24),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.logout_outlined,
                      color: Color(0xffec1c24),
                    ),
                    title: const Text('Cerrar sesión'),
                    onTap: () {
                      logout();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void logout() async {
    if (GetInfoUser.of(context).conexion!) {
      //await supabase.auth.signOut();
    }

    //exit(0); // Cerrar app en windows
    SystemNavigator.pop(); // Cerrar app en android
  }
}
