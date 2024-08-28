class Categoria {
  final String slug;
  final String name;
  final String url;

  Categoria({
    required this.slug,
    required this.name,
    required this.url,
  });

    Map toJson() => {
        'slug': slug,
        'name': name,
        'url': url,
      };
}
