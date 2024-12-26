// ignore_for_file: inference_failure_on_function_invocation

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/errors.dart';
import 'package:education_app/src/onboarding/domain/domain.dart';
import 'package:education_app/src/onboarding/onboarding.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnboardingCubit cubit;

  setUp(() {
    cacheFirstTimer = MockCacheFirstTimer();
    checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
    cubit = OnboardingCubit(
      cacheFirstTimer: cacheFirstTimer,
      checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
    );
  });

  final tFailure = CacheFailure(
    message: 'Insufficient storage permission',
    statusCode: 4032,
  );

  test('initial state should be [OnboardingInitial]', () {
    expect(cubit.state, const OnboardingInitial());
  });

  group('casheFirstTimer', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'Should emit [CachingFirstTimer, UserCached] when successful',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const [
        CachingFirstTimer(),
        UserCached(),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'Should emit [CachingFirstTimer, OnboardingError] when unsuccessful',
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => [
        const CachingFirstTimer(),
        OnboardingError(message: tFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
  });

  group('checkIfUserIsFirstTimer', () {
    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnboardingStatus] '
      'when successful',
      build: () {
        when(() => checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => const Right(false),
        );
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckingIfUserIsFirstTimer(),
        OnboardingStatus(isFirstTimer: false),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(checkIfUserIsFirstTimer);
      },
    );

    blocTest<OnboardingCubit, OnboardingState>(
      'should emit [CheckingIfUserIsFirstTimer, OnboardingStatus(true)] '
      'when unsuccessful',
      build: () {
        when(() => checkIfUserIsFirstTimer()).thenAnswer(
          (_) async => Left(tFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.checkIfUserIsFirstTimer(),
      expect: () => const [
        CheckingIfUserIsFirstTimer(),
        OnboardingStatus(isFirstTimer: true),
      ],
      verify: (_) {
        verify(() => checkIfUserIsFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
  });
}
