import 'package:dartz/dartz.dart';
import 'package:education_app/core/core.dart';
import 'package:education_app/src/onboarding/data/data.dart';
import 'package:education_app/src/onboarding/domain/domain.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  const OnboardingRepoImpl(this._localDataSource);

  final OnboardingLocalDataSource _localDataSource;

  @override
  ResultFuture<void> cacheFirstTimer() async {
    try {
      await _localDataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() {
    // TODO: implement checkIfUserIsFirstTimer
    throw UnimplementedError();
  }
}
