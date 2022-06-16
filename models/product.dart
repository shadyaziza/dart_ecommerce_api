import 'dart:convert';

import 'package:postgres/postgres.dart';

import '../db/config.dart';

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
  });

  final int id;
  final String name, description;
  final double price;
  final int discount;
  factory Product.fromRows(PostgreSQLResult rows) {
    late int id, discount;
    late String name, description;
    late double price;
    for (final row in rows) {
      id = row[0] as int;
      name = row[1] as String;
      description = row[2] as String;
      price = row[3] as double;
      discount = row[4] as int;
    }
    return Product(
      id: id,
      name: name,
      description: description,
      price: price,
      discount: discount,
    );
  }
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'discount': discount
      };

  String toJson() => json.encode(toMap());
}

const query = '''
SELECT * FROM public.product WHERE id=@id; 
''';

class ProductQueries {
  static Future<Product> getByID(String id) async {
    final result = await DatabaseConfig.instance.connection
        .query(query, substitutionValues: <String, String>{'id': id});

    return Product.fromRows(result);
  }
}

Map<int, Product> dummyProducts = {
  1: Product(
    id: 1,
    name: 'Product 1',
    description: 'Description 1',
    price: 10,
    discount: 25,
  ),
  2: Product(
    id: 2,
    name: 'Product 2',
    description: 'Description 2',
    price: 20,
    discount: 0,
  ),
  3: Product(
    id: 3,
    name: 'Product 3',
    description: 'Description 3',
    price: 30,
    discount: 50,
  ),
  4: Product(
    id: 4,
    name: 'Product 4',
    description: 'Description 4',
    price: 40,
    discount: 0,
  ),
  5: Product(
    id: 5,
    name: 'Product 5',
    description: 'Description 5',
    price: 50,
    discount: 0,
  ),
  6: Product(
    id: 6,
    name: 'Product 6',
    description: 'Description 6',
    price: 60,
    discount: 0,
  ),
  7: Product(
    id: 7,
    name: 'Product 7',
    description: 'Description 7',
    price: 70,
    discount: 0,
  ),
  8: Product(
    id: 8,
    name: 'Product 8',
    description: 'Description 8',
    price: 80,
    discount: 40,
  ),
  9: Product(
    id: 9,
    name: 'Product 9',
    description: 'Description 9',
    price: 90,
    discount: 0,
  ),
  10: Product(
    id: 10,
    name: 'Product 10',
    description: 'Description 10',
    price: 100,
    discount: 10,
  ),
};
