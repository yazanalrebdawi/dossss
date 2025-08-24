import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';
import 'package:dooss_business_app/features/home/data/data_source/product_remote_data_source.dart';

// Cubit
class ProductCubit extends Cubit<ProductState> {
  final ProductRemoteDataSource dataSource;
  
  ProductCubit(this.dataSource) : super(const ProductState());

  void loadProducts() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final allProducts = await dataSource.fetchProducts();
      
      // Take first 10 products for home screen
      final homeProducts = allProducts.take(10).toList();
      
      emit(state.copyWith(
        products: homeProducts,
        allProducts: allProducts,
        isLoading: false,
      ));
    } catch (e) {
      print('ProductCubit error: $e');
      emit(state.copyWith(error: 'Failed to load products', isLoading: false));
    }
  }

  void loadAllProducts() async {
    // If we already have all products, use them
    if (state.allProducts.isNotEmpty) {
      final first8Products = state.allProducts.take(8).toList();
      emit(state.copyWith(
        filteredProducts: state.allProducts,
        displayedProducts: first8Products,
        selectedCategory: 'All',
        hasMoreProducts: state.allProducts.length > 8,
      ));
      return;
    }

    // Otherwise, fetch from API
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final allProducts = await dataSource.fetchProducts();
      final first8Products = allProducts.take(8).toList();
      emit(state.copyWith(
        allProducts: allProducts,
        filteredProducts: allProducts,
        displayedProducts: first8Products,
        selectedCategory: 'All',
        hasMoreProducts: allProducts.length > 8,
        isLoading: false,
      ));
    } catch (e) {
      print('ProductCubit loadAllProducts error: $e');
      emit(state.copyWith(error: 'Failed to load all products', isLoading: false));
    }
  }

  void showHomeProducts() {
    // Show only first 10 products
    final homeProducts = state.allProducts.take(10).toList();
    emit(state.copyWith(products: homeProducts));
  }

  void filterByCategory(String category) {
    if (category == 'All') {
      final first8Products = state.allProducts.take(8).toList();
      emit(state.copyWith(
        filteredProducts: state.allProducts,
        displayedProducts: first8Products,
        selectedCategory: category,
        hasMoreProducts: state.allProducts.length > 8,
      ));
    } else {
      // Filter products by category (mock filtering for now)
      final filteredProducts = state.allProducts.where((product) {
        // Mock category filtering - in real app, this would be based on product.category
        return product.name.toLowerCase().contains(category.toLowerCase()) ||
               product.description.toLowerCase().contains(category.toLowerCase());
      }).toList();
      
      final first8Products = filteredProducts.take(8).toList();
      emit(state.copyWith(
        filteredProducts: filteredProducts,
        displayedProducts: first8Products,
        selectedCategory: category,
        hasMoreProducts: filteredProducts.length > 8,
      ));
    }
  }

  void loadMoreProducts() {
    if (state.isLoadingMore || !state.hasMoreProducts) return;
    
    emit(state.copyWith(isLoadingMore: true));
    
    final currentDisplayedCount = state.displayedProducts.length;
    final next8Products = state.filteredProducts.skip(currentDisplayedCount).take(8).toList();
    final newDisplayedProducts = [...state.displayedProducts, ...next8Products];
    
    emit(state.copyWith(
      displayedProducts: newDisplayedProducts,
      hasMoreProducts: newDisplayedProducts.length < state.filteredProducts.length,
      isLoadingMore: false,
    ));
  }

  void loadProductDetails(int productId) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      // Load product details from API
      final product = await dataSource.fetchProductDetails(productId);
      
      // Load related products
      final relatedProducts = await dataSource.fetchRelatedProducts(productId);
      
      // Load product reviews
      final reviews = await dataSource.fetchProductReviews(productId);
      
      emit(state.copyWith(
        selectedProduct: product,
        relatedProducts: relatedProducts,
        productReviews: reviews,
        isLoading: false,
      ));
    } catch (e) {
      print('ProductCubit loadProductDetails error: $e');
      emit(state.copyWith(error: 'Failed to load product details', isLoading: false));
    }
  }

  void toggleProductFavorite(int productId) {
    // Here you would typically update the favorite status in the backend
    // For now, we'll just emit the same state
    emit(state.copyWith());
  }
}
