import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv/top_rated_tv_event.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated_tv/top_rated_tv_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedTVBloc extends Bloc<TopRatedTVEvent, TopRatedTVState> {
  final GetTopRatedTV getTopRatedTV;

  TopRatedTVBloc({required this.getTopRatedTV}) : super(TopRatedTVInitial()) {
    on<FetchTopRatedTVList>(_onFetchTopRatedTVList);
  }

  Future<void> _onFetchTopRatedTVList(
    FetchTopRatedTVList event,
    Emitter<TopRatedTVState> emit,
  ) async {
    emit(TopRatedTVLoading());

    final result = await getTopRatedTV.execute();
    result.fold(
      (failure) {
        emit(TopRatedTVError(failure.message));
      },
      (data) {
        emit(TopRatedTVLoaded(data));
      },
    );
  }
}
