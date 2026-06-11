import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:core/common/failure.dart';

class GetWatchlistTV {
  final TVRepository repository;

  GetWatchlistTV(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getWatchlistTv();
  }
}
