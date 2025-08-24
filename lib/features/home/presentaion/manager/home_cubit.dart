import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

// Cubit
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void updateCurrentIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void updateSelectedBrowseType(int type) {
    emit(state.copyWith(selectedBrowseType: type));
  }

  void setLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
}
