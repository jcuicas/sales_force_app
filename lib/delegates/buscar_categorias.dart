import 'package:flutter/material.dart';
import 'package:app_force_sales/extensions/extension_string.dart';
import 'package:app_force_sales/models/categorias.dart';

class BuscarCategoria extends SearchDelegate<Categoria> {
  final List<Categoria> listaCategorias;

  List<Categoria> _filtroCategorias = [];

  BuscarCategoria({
    required this.listaCategorias,
  });

  @override
  String? get searchFieldLabel => 'Buscar categoria';

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
          Categoria(slug: '', name: '', url: ''),
        );
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Categoria> categorias = [];

    for (var item in listaCategorias) {
      if (item.name.contains(query.capitalize().trim())) {
        categorias.add(
          Categoria(
            slug: item.slug,
            name: item.name,
            url: item.url,
          ),
        );
      }
    }

    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                categorias[index].name.substring(0, 2),
              ),
            ),
            title: Text(categorias[index].name),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _filtroCategorias = listaCategorias.where(
      (categoria) {
        return categoria.name.contains(
            query.isNotEmpty ? query.capitalize().trim() : query = '');
      },
    ).toList();

    return ListView.builder(
      itemCount: _filtroCategorias.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                _filtroCategorias[index].name.substring(0, 2),
              ),
            ),
            title: Text(_filtroCategorias[index].name),
          ),
        );
      },
    );
  }
}
