import 'package:tv_series/domain/repositories/tv_repository.dart';

class GetWatchListStatusTV {
  final TVRepository repository;

  GetWatchListStatusTV(this.repository);

  Future<bool> execute(int id) {
    return repository.isAddedToWatchlistTv(id);
  }
}
