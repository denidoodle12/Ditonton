import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter/foundation.dart';

class TvSeasonDetailNotifier extends ChangeNotifier {
  final GetTvSeasonDetail getTvSeasonDetail;

  TvSeasonDetailNotifier({required this.getTvSeasonDetail});

  RequestState _seasonState = RequestState.Empty;
  RequestState get seasonState => _seasonState;

  List<Episode> _episodes = [];
  List<Episode> get episodes => _episodes;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeasonDetail(int tvId, int seasonNumber) async {
    _seasonState = RequestState.Loading;
    notifyListeners();

    final result = await getTvSeasonDetail.execute(tvId, seasonNumber);
    result.fold(
      (failure) {
        _seasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (episodesData) {
        _seasonState = RequestState.Loaded;
        _episodes = episodesData;
        notifyListeners();
      },
    );
  }
}
