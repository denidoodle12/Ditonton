import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/common/failure.dart';

abstract class TVRepository {
  Future<Either<Failure, List<TV>>> getOnTheAirTv();
  Future<Either<Failure, List<TV>>> getPopularTv();
  Future<Either<Failure, List<TV>>> getTopRatedTv();
  Future<Either<Failure, TVDetail>> getTVDetail(int id);
  Future<Either<Failure, List<TV>>> getTvRecommendations(int id);
  Future<Either<Failure, List<TV>>> searchTv(String query);
  Future<Either<Failure, String>> saveWatchlistTv(TVDetail tv);
  Future<Either<Failure, String>> removeWatchlistTv(TVDetail tv);
  Future<bool> isAddedToWatchlistTv(int id);
  Future<Either<Failure, List<TV>>> getWatchlistTv();
  Future<Either<Failure, List<Episode>>> getTvSeasonDetail(
      int tvId, int seasonNumber);
}
