import 'package:education_app/core/core.dart';
import 'package:education_app/src/onboarding/data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnboardingLocalDataSource localDataSource;

  setUp(() {
    prefs = MockSharedPreferences();
    localDataSource = OnboardingLocalDataSourceImpl(prefs);
  });

  group('cacheFirstTimer', () {
    test('should call [SharedPreferences] to cache the data', () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(() => prefs.setBool(any(), any())).thenAnswer((_) async => true);

      //Act - Call the function that is to be tested
      await localDataSource.cacheFirstTimer();

      //Assert - Compare the actual result and expected result
      verify(
        () => prefs.setBool(kFirstTimerKey, false),
      ).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw a [CacheException] when there is an error caching '
        'the data', () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(() => prefs.setBool(any(), any())).thenThrow(Exception());

      //Act - Call the function that is to be tested
      final methodCall = localDataSource.cacheFirstTimer;

      //Assert - Compare the actual result and expected result
      expect(methodCall, throwsA(isA<CacheException>()));
      verify(
        () => prefs.setBool(kFirstTimerKey, false),
      ).called(1);
      verifyNoMoreInteractions(prefs);
    });
  });

  group('checkIfUserIsFirstTimer', () {
    test(
        'should call [SharedPreferences] to check if the user is first timer '
        'and return the right response from storage when data exists',
        () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(() => prefs.getBool(any())).thenReturn(false);

      //Act - Call the function that is to be tested
      final result = await localDataSource.checkIfUserIsFirstTimer();

      //Assert - Compare the actual result and expected result
      expect(result, false);
      verify(
        () => prefs.getBool(kFirstTimerKey),
      ).called(1);
      verifyNoMoreInteractions(prefs);
    });

    test('should return true if there is no data in storage', () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(() => prefs.getBool(any())).thenReturn(null);

      //Act - Call the function that is to be tested
      final result = await localDataSource.checkIfUserIsFirstTimer();

      //Assert - Compare the actual result and expected result
      expect(result, true);

      verify(
        () => prefs.getBool(kFirstTimerKey),
      ).called(1);

      verifyNoMoreInteractions(prefs);
    });

    test(
        'should throw a [CacheException] when there is an error '
        'retrieving the data', () async {
      //Arrange - Setup facts, Put Expected outputs or Initilize
      when(() => prefs.getBool(any())).thenThrow(Exception());

      //Act - Call the function that is to be tested
      final call = localDataSource.checkIfUserIsFirstTimer;

      //Assert - Compare the actual result and expected result
      expect(call, throwsA(isA<CacheException>()));

      verify(
        () => prefs.getBool(kFirstTimerKey),
      ).called(1);

      verifyNoMoreInteractions(prefs);
    });
  });
}
