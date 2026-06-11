import 'package:tv_series/domain/usecases/get_popular_tv.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_event.dart';
import 'package:tv_series/presentation/bloc/popular_tv/popular_tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTV getPopularTV;

  PopularTVBloc({required this.getPopularTV}) : super(PopularTVInitial()) {
    on<FetchPopularTVList>(_onFetchPopularTVList);
  }

  Future<void> _onFetchPopularTVList(
    FetchPopularTVList event,
    Emitter<PopularTVState> emit,
  ) async {
    emit(PopularTVLoading());

    final result = await getPopularTV.execute();
    result.fold(
      (failure) {
        emit(PopularTVError(failure.message));
      },
      (data) {
        emit(PopularTVLoaded(data));
      },
    );
  }
}
