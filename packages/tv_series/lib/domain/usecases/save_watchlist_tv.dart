import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';

class SaveWatchlistTV {
  final TVRepository repository;

  SaveWatchlistTV(this.repository);

  Future<Either<Failure, String>> execute(TVDetail tv) {
    return repository.saveWatchlistTv(tv);
  }
}
