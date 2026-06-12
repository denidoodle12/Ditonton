import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/search_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTV usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTV(mockTVRepository);
  });

  final tQuery = 'Squid Game';
  final tTVList = <TV>[];

  test('should get list of tv from the repository', () async {
    // arrange
    when(mockTVRepository.searchTv(tQuery))
        .thenAnswer((_) async => Right(tTVList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTVList));
  });
}
