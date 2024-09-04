import 'package:dartz/dartz.dart';
import 'package:education_app/core/core.dart';
import 'package:education_app/src/onboarding/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'usecases.dart';

void main() {
  late OnboardingRepo repo;
  late CacheFirstTimer usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CacheFirstTimer(repo);
  });

  test(
      'should call the [OnboardingRepo.cacheFirstTimer] '
      'and return the right data', () async {
    //Arrange - Setup facts, Put Expected outputs or Initilize
    when(() => repo.cacheFirstTimer()).thenAnswer(
      (_) async => Left(
        ServerFailure(
          message: 'Unknown Error Occurred',
          statusCode: 500,
        ),
      ),
    );

    //Act - Call the function that is to be tested
    final result = await usecase();

    //Assert - Compare the actual result and expected result
    expect(
      result,
      equals(
        Left<Failure, dynamic>(
          ServerFailure(
            message: 'Unknown Error Occurred',
            statusCode: 500,
          ),
        ),
      ),
    );
    verify(() => repo.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
