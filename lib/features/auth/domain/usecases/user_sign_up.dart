import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/use_cases.dart';
import 'package:blog_app/core/common/entity/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCases<UserEntity, SignUpParams> {
  final AuthRepository repository;
  UserSignUp(this.repository);
  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) async {
    return await repository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String email;
  final String name;
  final String password;

  const SignUpParams({required this.email, required this.name, required this.password});
}
