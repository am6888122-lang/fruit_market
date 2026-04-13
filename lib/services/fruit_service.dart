import 'package:dio/dio.dart';
import 'package:fruit_market/models/product_api_model.dart';

class FruitService {
  final Dio _dio = Dio();
  final String _url = 'https://dummyjson.com/products?limit=100';

  Future<List<ProductApiModel>> fetchProducts() async {
    try {
      final response = await _dio.get(_url);
      if (response.statusCode == 200) {
        ProductResponse productResponse = ProductResponse.fromJson(response.data);
        return productResponse.products;
      } else {
        throw Exception("Failed to load products. Status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
