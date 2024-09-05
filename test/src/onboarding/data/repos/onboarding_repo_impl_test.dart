import 'package:dartz/dartz.dart';
import 'package:education_app/core/core.dart';
import 'package:education_app/src/onboarding/data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingLocalDataSource extends Mock
    implements OnboardingLocalDataSource {}

void main() {
  late OnboardingLocalDataSource localDataSource;
  late OnboardingRepoImpl repoImpl;

  setUp(() {
    localDataSource = MockOnboardingLocalDataSource();
    repoImpl = OnboardingRepoImpl(localDataSource);
  });

  test('should be a subclass of [OnboardingRepo]', () {
    //Arrange - Setup facts, Put Expected outputs or Initilize
    expect(repoImpl, isA<OnboardingRepoImpl>());
  });

  group('cacheFirstTimer', () {
    test('should complete successfully when call to local source is successful',
        () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(() => localDataSource.cacheFirstTimer())
          .thenAnswer((_) async => Future.value());

      //Act - Call the function that is to be tested
      final result = await repoImpl.cacheFirstTimer();

      //Assert - Compare the actual result and expected result
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => localDataSource.cacheFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });

    test(
        'should return [CacheFailure] when call to local source is '
        'unsuccessful', () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(() => localDataSource.cacheFirstTimer()).thenThrow(
        const CacheException(
          message: 'Insufficient storage',
        ),
      );

      //Act - Call the function that is to be tested
      final result = await repoImpl.cacheFirstTimer();

      //Assert - Compare the actual result and expected result
      expect(
        result,
        Left<CacheFailure, dynamic>(
          CacheFailure(message: 'Insufficient storage', statusCode: 500),
        ),
      );
      verify(() => localDataSource.cacheFirstTimer());
      verifyNoMoreInteractions(localDataSource);
    });
  });
}
