import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetWatchlistTV {
  final TVRepository repository;

  GetWatchlistTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getWatchlistTv();
  }
}
