// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:app_force_sales/models/cliente.dart';
import 'package:app_force_sales/extensions/extension_string.dart';

class BuscarCliente extends SearchDelegate<Cliente> {
  final List<Cliente> listaClientes;

  List<Cliente> _filtroClientes = [];

  BuscarCliente({
    required this.listaClientes,
  });

  @override
  String? get searchFieldLabel => 'Buscar cliente';

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
          Cliente(id: '', phone: '', company: '', address: ''),
        );
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Cliente> clientes = [];

    for (var item in listaClientes) {
      if (item.company.contains(query.capitalize().trim())) {
        clientes.add(
          Cliente(
            id: item.id,
            phone: item.phone,
            company: item.company,
            address: item.address,
          ),
        );
      }
    }

    return ListView.builder(
      itemCount: clientes.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                clientes[index].company.substring(0, 2),
              ),
            ),
            title: Text(clientes[index].company),
            subtitle: Text(clientes[index].address),
            trailing: Text(clientes[index].phone),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filtroClientes = listaClientes.where(
      (cliente) {
        return cliente.company.contains(query.isNotEmpty ? query.capitalize().trim() : query = '');
      },
    ).toList();

    return ListView.builder(
      itemCount: _filtroClientes.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                _filtroClientes[index].company.substring(0, 2),
              ),
            ),
            title: Text(_filtroClientes[index].company),
            subtitle: Text(_filtroClientes[index].address),
            trailing: Text(_filtroClientes[index].phone),
          ),
        );
      },
    );
  }
}
