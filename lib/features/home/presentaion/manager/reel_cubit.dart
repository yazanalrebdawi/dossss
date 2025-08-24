import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/data_source/reel_remote_data_source.dart';
import '../../data/models/reel_model.dart';
import 'reel_state.dart';

class ReelCubit extends Cubit<ReelState> {
  final ReelRemoteDataSource dataSource;

  ReelCubit({required this.dataSource}) : super(ReelState.initial());

  void loadReels({int page = 1, int pageSize = 20}) async {
    emit(state.copyWith(isLoading: true, error: null));
    
    final result = await dataSource.fetchReels(
      page: page,
      pageSize: pageSize,
      ordering: '-created_at',
    );

    result.fold(
      (failure) {
        print('❌ ReelCubit: Error loading reels: ${failure.message}');
        emit(state.copyWith(
          error: failure.message,
          isLoading: false,
        ));
      },
      (reelsResponse) {
        print('✅ ReelCubit: Successfully loaded ${reelsResponse.results.length} reels');
        
        // If it's the first page, replace the list, otherwise append
        final updatedReels = page == 1 
            ? reelsResponse.results 
            : [...state.reels, ...reelsResponse.results];
        
        emit(state.copyWith(
          reels: updatedReels,
          isLoading: false,
          hasNextPage: reelsResponse.next != null,
          currentPage: page,
          totalCount: reelsResponse.count,
        ));
      },
    );
  }

  void loadMoreReels() async {
    if (state.isLoading || !state.hasNextPage) return;
    
    final nextPage = state.currentPage + 1;
    print('🔄 ReelCubit: Loading more reels (page: $nextPage)...');
    
    final result = await dataSource.fetchReels(
      page: nextPage,
      pageSize: 20,
      ordering: '-created_at',
    );

    result.fold(
      (failure) {
        print('❌ ReelCubit: Error loading more reels: ${failure.message}');
        emit(state.copyWith(error: failure.message));
      },
      (reelsResponse) {
        print('✅ ReelCubit: Successfully loaded ${reelsResponse.results.length} more reels');
        
        emit(state.copyWith(
          reels: [...state.reels, ...reelsResponse.results],
          hasNextPage: reelsResponse.next != null,
          currentPage: nextPage,
          error: null,
        ));
      },
    );
  }

  void refreshReels() async {
    print('🔄 ReelCubit: Refreshing reels...');
    loadReels(page: 1, pageSize: 20);
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }

  void resetState() {
    emit(ReelState.initial());
  }
}
