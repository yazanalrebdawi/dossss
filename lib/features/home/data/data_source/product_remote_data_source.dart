import 'package:dooss_business_app/features/home/data/models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts();
  Future<List<ProductModel>> fetchProductsByCategory(String category);
  Future<ProductModel> fetchProductDetails(int productId);
  Future<List<ProductModel>> fetchRelatedProducts(int productId);
  Future<List<Map<String, dynamic>>> fetchProductReviews(int productId);
}
