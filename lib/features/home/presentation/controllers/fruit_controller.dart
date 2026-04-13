import 'package:get/get.dart';
import 'package:fruit_market/models/product_api_model.dart';
import 'package:fruit_market/services/fruit_service.dart';

class FruitController extends GetxController {
  final FruitService _service = FruitService();
  var products = <ProductApiModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchFruits();
  }

  Future<void> fetchFruits() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      final result = await _service.fetchProducts();
      
      // Filter for grocery / fruit related products
      // In DummyJSON, the category is "groceries"
      products.assignAll(result.where((p) => p.category.toLowerCase() == "groceries").toList());
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
