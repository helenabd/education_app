import 'package:bloc/bloc.dart';
import 'package:education_app/src/onboarding/domain/domain.dart';
import 'package:education_app/src/onboarding/domain/usecases/usecases.dart';
import 'package:education_app/src/onboarding/onboarding.dart';
import 'package:education_app/src/onboarding/presentation/cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required CacheFirstTimer cacheFirstTimer,
    required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer,
  })  : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(const OnboardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  Future<void> cacheFirstTimer() async {
    final result = await _cacheFirstTimer();

    result.fold(
      (failure) => emit(OnboardingError(message: failure.errorMessage)),
      (_) => emit(const UserCached()),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    final result = await _checkIfUserIsFirstTimer();

    result.fold(
      (failure) => emit(
        const OnboardingStatus(
          isFirstTimer: true,
        ),
      ),
      (status) => emit(OnboardingStatus(isFirstTimer: status)),
    );
  }
}
