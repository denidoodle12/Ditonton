import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:tv_series/domain/repositories/tv_repository.dart';
import 'package:core/common/failure.dart';

class GetTVDetail {
  final TVRepository repository;

  GetTVDetail(this.repository);

  Future<Either<Failure, TVDetail>> execute(int id) {
    return repository.getTVDetail(id);
  }
}
