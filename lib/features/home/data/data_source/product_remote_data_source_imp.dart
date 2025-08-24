import 'package:dooss_business_app/core/network/api.dart';
import 'package:dooss_business_app/core/network/api_request.dart';
import 'package:dooss_business_app/core/network/api_urls.dart';
import 'package:dooss_business_app/features/home/data/models/product_model.dart';
import 'product_remote_data_source.dart';

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  final API api;
  ProductRemoteDataSourceImp({required this.api});

  @override
  Future<List<ProductModel>> fetchProducts() async {
    try {
      print('Fetching products from API...');
      final response = await api.get(
        apiRequest: ApiRequest(url: ApiUrls.products),
      );
      print('API response: $response');
      return response.fold(
        (failure) {
          print('Failure: ${failure.message}');
          // Return empty list if API fails, don't throw exception
          return <ProductModel>[];
        },
        (data) {
          print('Data received: $data');
          if (data is List) {
            return data.map((e) => ProductModel.fromJson(e)).toList();
          } else {
            print('Invalid data format received from API');
            return <ProductModel>[];
          }
        },
      );
    } catch (e) {
      print('ProductRemoteDataSource error: $e');
      // Return empty list if any error occurs
      return <ProductModel>[];
    }
  }

  @override
  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    try {
      print('Fetching products by category from API...');
      final response = await api.get(
        apiRequest: ApiRequest(url: '${ApiUrls.products}?category=$category'),
      );
      print('API response: $response');
      return response.fold(
        (failure) {
          print('Failure: ${failure.message}');
          // Return empty list if API fails, don't throw exception
          return <ProductModel>[];
        },
        (data) {
          print('Data received: $data');
          if (data is List) {
            return data.map((e) => ProductModel.fromJson(e)).toList();
          } else {
            print('Invalid data format received from API');
            return <ProductModel>[];
          }
        },
      );
    } catch (e) {
      print('ProductRemoteDataSource error: $e');
      // Return empty list if any error occurs
      return <ProductModel>[];
    }
  }

  @override
  Future<ProductModel> fetchProductDetails(int productId) async {
    try {
      print('Fetching product details from API...');
      final url = '${ApiUrls.products}$productId/';
      print('Constructed URL: $url');
      final response = await api.get(
        apiRequest: ApiRequest(url: url),
      );
      print('API response: $response');
      return response.fold(
        (failure) {
          print('Failure: ${failure.message}');
          throw Exception('Failed to load product details');
        },
        (data) {
          print('Data received: $data');
          return ProductModel.fromJson(data);
        },
      );
    } catch (e) {
      print('ProductRemoteDataSource fetchProductDetails error: $e');
      throw Exception('Failed to load product details');
    }
  }

  @override
  Future<List<ProductModel>> fetchRelatedProducts(int productId) async {
    try {
      print('Fetching related products from API...');
      final response = await api.get(
        apiRequest: ApiRequest(url: '${ApiUrls.products}$productId/related/'),
      );
      print('API response: $response');
      return response.fold(
        (failure) {
          print('Failure: ${failure.message}');
          return <ProductModel>[];
        },
        (data) {
          print('Data received: $data');
          if (data is List) {
            return data.map((e) => ProductModel.fromJson(e)).toList();
          } else {
            print('Invalid data format received from API');
            return <ProductModel>[];
          }
        },
      );
    } catch (e) {
      print('ProductRemoteDataSource fetchRelatedProducts error: $e');
      return <ProductModel>[];
    }
  }

  @override
  Future<List<Map<String, dynamic>>> fetchProductReviews(int productId) async {
    try {
      print('Fetching product reviews from API...');
      final response = await api.get(
        apiRequest: ApiRequest(url: '${ApiUrls.products}$productId/reviews/'),
      );
      print('API response: $response');
      return response.fold(
        (failure) {
          print('Failure: ${failure.message}');
          return <Map<String, dynamic>>[];
        },
        (data) {
          print('Data received: $data');
          if (data is List) {
            return data.cast<Map<String, dynamic>>();
          } else {
            print('Invalid data format received from API');
            return <Map<String, dynamic>>[];
          }
        },
      );
    } catch (e) {
      print('ProductRemoteDataSource fetchProductReviews error: $e');
      return <Map<String, dynamic>>[];
    }
  }
}
