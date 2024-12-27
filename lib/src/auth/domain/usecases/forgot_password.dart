import 'package:education_app/core/core.dart';
import 'package:education_app/src/auth/domain/domain.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  const ForgotPassword(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) async => _repo.forgotPassword(params);
}
