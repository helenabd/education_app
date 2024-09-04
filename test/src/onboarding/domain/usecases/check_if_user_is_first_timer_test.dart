import 'package:dartz/dartz.dart';
import 'package:education_app/src/onboarding/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'onboarding_repo.mock.dart';

void main() {
  late MockOnboardingRepo repo;
  late CheckIfUserIsFirstTimer usecase;

  setUp(() {
    repo = MockOnboardingRepo();
    usecase = CheckIfUserIsFirstTimer(repo);
  });

  test(
    'should get a response from the [MockOnboardingRepo]',
    () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(() => repo.checkIfUserIsFirstTimer()).thenAnswer(
        (_) async => const Right(true),
      );

      //Act - Call the function that is to be tested
      final result = await usecase();

      //Assert - Compare the actual result and expected result
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => repo.checkIfUserIsFirstTimer()).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
