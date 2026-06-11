import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search/tv_search_event.dart';
import 'package:ditonton/presentation/bloc/tv/tv_search/tv_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TVSearchBloc extends Bloc<TVSearchEvent, TVSearchState> {
  final SearchTV searchTV;

  TVSearchBloc({required this.searchTV}) : super(TVSearchInitial()) {
    on<SearchTVQuery>(_onSearchTVQuery);
  }

  Future<void> _onSearchTVQuery(
    SearchTVQuery event,
    Emitter<TVSearchState> emit,
  ) async {
    emit(TVSearchLoading());

    final result = await searchTV.execute(event.query);
    result.fold(
      (failure) {
        emit(TVSearchError(failure.message));
      },
      (data) {
        emit(TVSearchLoaded(data));
      },
    );
  }
}
