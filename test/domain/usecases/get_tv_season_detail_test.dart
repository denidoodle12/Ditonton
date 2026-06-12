import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/episode.dart';
import 'package:tv_series/domain/usecases/get_tv_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTVSeasonDetail usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = GetTVSeasonDetail(mockTVRepository);
  });

  final tTvId = 1;
  final tSeasonNumber = 1;
  final tEpisodes = <Episode>[];

  test('should get list of episodes from the repository', () async {
    // arrange
    when(mockTVRepository.getTvSeasonDetail(tTvId, tSeasonNumber))
        .thenAnswer((_) async => Right(tEpisodes));
    // act
    final result = await usecase.execute(tTvId, tSeasonNumber);
    // assert
    expect(result, Right(tEpisodes));
  });
}
