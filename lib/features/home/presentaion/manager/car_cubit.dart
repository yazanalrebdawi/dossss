import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_source/car_remote_data_source.dart';
import '../../data/models/car_model.dart';
import 'car_state.dart';

class CarCubit extends Cubit<CarState> {
  final CarRemoteDataSource _carRemoteDataSource;

  CarCubit(this._carRemoteDataSource) : super(const CarState());

  // Load cars for home screen (first 10 items)
  void loadCars() async {
    print('🚀 CarCubit - Starting to load cars');
    emit(state.copyWith(isLoading: true, error: null));
    
    try {
      final allCars = await _carRemoteDataSource.fetchCars();
      print('✅ CarCubit - Successfully fetched ${allCars.length} cars');
      // Take only first 10 cars for home screen
      final homeCars = allCars.take(10).toList();
      emit(state.copyWith(
        cars: homeCars,
        allCars: allCars, // Store all cars for "See All" functionality
        isLoading: false,
      ));
    } catch (e) {
      print('❌ CarCubit - Failed to load cars: $e');
      emit(state.copyWith(
        error: 'Failed to load cars',
        isLoading: false,
      ));
    }
  }

  // Load all cars for "See All Cars" screen with pagination
  void loadAllCars() async {
    emit(state.copyWith(isLoading: true, error: null, currentPage: 1));
    
    try {
      final allCars = await _carRemoteDataSource.fetchCars();
      final firstPageCars = allCars.take(10).toList();
      
      emit(state.copyWith(
        allCars: allCars,
        cars: firstPageCars, // Show first 10 cars
        isLoading: false,
        currentPage: 1,
        hasMoreCars: allCars.length > 10,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load all cars',
        isLoading: false,
      ));
    }
  }

  // Load more cars (pagination)
  void loadMoreCars() async {
    if (state.isLoadingMore || !state.hasMoreCars) return;
    
    emit(state.copyWith(isLoadingMore: true));
    
    try {
      final nextPage = state.currentPage + 1;
      final startIndex = (nextPage - 1) * 10;
      final endIndex = startIndex + 10;
      
      if (startIndex < state.allCars.length) {
        final newCars = state.allCars.skip(startIndex).take(10).toList();
        final updatedCars = [...state.cars, ...newCars];
        
        emit(state.copyWith(
          cars: updatedCars,
          currentPage: nextPage,
          hasMoreCars: endIndex < state.allCars.length,
          isLoadingMore: false,
        ));
      } else {
        emit(state.copyWith(
          hasMoreCars: false,
          isLoadingMore: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        error: 'Failed to load more cars',
        isLoadingMore: false,
      ));
    }
  }

  // Filter cars by brand
  void filterByBrand(String brand) {
    if (brand.isEmpty) {
      emit(state.copyWith(cars: state.allCars, selectedBrand: ''));
    } else {
      final filteredCars = state.allCars.where((car) => car.brand == brand).toList();
      emit(state.copyWith(
        cars: filteredCars,
        selectedBrand: brand,
      ));
    }
  }

  // Clear filters
  void clearFilters() {
    emit(state.copyWith(
      cars: state.allCars,
      selectedBrand: '',
    ));
  }

  // Search cars
  void searchCars(String query) {
    if (query.isEmpty) {
      emit(state.copyWith(cars: state.allCars));
    } else {
      final searchResults = state.allCars
          .where((car) => 
              car.name.toLowerCase().contains(query.toLowerCase()) ||
              car.brand.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(state.copyWith(cars: searchResults));
    }
  }

  // Toggle favorite (for home screen)
  void toggleFavorite(int carId) {
    final updatedCars = state.cars.map((car) {
      if (car.id == carId) {
        return car.copyWith(isFavorite: !car.isFavorite);
      }
      return car;
    }).toList();
    emit(state.copyWith(cars: updatedCars));
  }

  // Show only first 10 cars (for returning from "See All" to home)
  void showHomeCars() {
    if (state.allCars.isNotEmpty) {
      final homeCars = state.allCars.take(10).toList();
      emit(state.copyWith(cars: homeCars));
    }
  }

  // Get total number of cars available
  int get totalCarsCount => state.allCars.length;

  // Check if there are more cars to show
  bool get hasMoreCars => state.allCars.length > 10;

  // Load car details for car details screen
  Future<void> loadCarDetails(int carId) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await _carRemoteDataSource.fetchCarDetails(carId);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        ));
      },
      (car) {
        emit(state.copyWith(
          isLoading: false,
          selectedCar: car,
        ));
        
        // Load similar cars after loading car details
        _loadSimilarCars(carId);
      },
    );
  }

  Future<void> _loadSimilarCars(int carId) async {
    final result = await _carRemoteDataSource.fetchSimilarCars(carId);

    result.fold(
      (failure) {
        // Don't emit error for similar cars, just log it
        print('Failed to load similar cars: ${failure.message}');
      },
      (similarCars) {
        emit(state.copyWith(similarCars: similarCars));
      },
    );
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }
}
