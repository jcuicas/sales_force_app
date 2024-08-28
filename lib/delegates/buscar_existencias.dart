import 'package:flutter/material.dart';
import 'package:app_force_sales/extensions/extension_string.dart';
import 'package:app_force_sales/models/productos.dart';

class BuscarExistencia extends SearchDelegate<Producto> {
  final List<Producto> listaProductos;

  List<Producto> _filtroProductos = [];

  BuscarExistencia({
    required this.listaProductos,
  });

  @override
  String? get searchFieldLabel => 'Buscar productos';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
          context,
          Producto(id: '', title: '', category: '', price: '', stock: ''),
        );
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Producto> productos = [];

    for (var item in listaProductos) {
      if (item.title.contains(query.capitalize().trim())) {
        productos.add(
          Producto(
            id: item.id,
            title: item.title,
            category: item.category,
            price: item.price,
            stock: item.stock,
          ),
        );
      }
    }

    return ListView.builder(
      itemCount: productos.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                productos[index].title.substring(0, 2),
              ),
            ),
            title: Text(productos[index].title),
            subtitle: Text(productos[index].category),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filtroProductos = listaProductos.where(
      (producto) {
        return producto.title.contains(
            query.isNotEmpty ? query.capitalize().trim() : query = '');
      },
    ).toList();

    return ListView.builder(
      itemCount: _filtroProductos.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                _filtroProductos[index].title.substring(0, 2),
              ),
            ),
            title: Text(_filtroProductos[index].title),
            subtitle: Text(_filtroProductos[index].category),
            trailing: Text('${_filtroProductos[index].stock} stok'),
          ),
        );
      },
    );
  }
}
