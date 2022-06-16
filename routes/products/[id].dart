import 'package:dart_frog/dart_frog.dart';

import '../../models/product.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  // final product = await ProductQueries.getByID(id);

  final product = dummyProducts[int.parse(id)];
  if (product != null) {
    return Response(body: product.toJson());
  }
  return Response.json(body: {'error': 'Product not found', 'status': 404});
}
