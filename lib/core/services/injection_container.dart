import 'package:education_app/src/onboarding/data/data.dart';
import 'package:education_app/src/onboarding/domain/domain.dart';
import 'package:education_app/src/onboarding/presentation/presentation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  // Bloc - Business logic
  sl
    ..registerFactory(() => OnboardingCubit(
          cacheFirstTimer: sl(),
          checkIfUserIsFirstTimer: sl(),
        ))

    // Use cases
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(
      () => CheckIfUserIsFirstTimer(sl()),
    )

    // Repository
    ..registerLazySingleton<OnboardingRepo>(
      () => OnboardingRepoImpl(sl()),
    )

    // Data sources
    ..registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(sl()),
    )

    // External
    ..registerLazySingleton(() => prefs);
}
