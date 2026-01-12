import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/use_cases.dart';
import 'package:blog_app/core/common/entity/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogIn implements UseCases<UserEntity, SignUpParams> {
  final AuthRepository repository;
  UserLogIn(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.logInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;

  const SignUpParams({required this.email,required this.password});
}
