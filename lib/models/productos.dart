class Producto {
  final String id;
  final String title;
  final String category;
  final String price;
  final String stock;

  Producto({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.stock,
  });

  Map toJson() => {
        'id': id,
        'title': title,
        'category': category,
        'price': price,
        'stock': stock,
      };
}
