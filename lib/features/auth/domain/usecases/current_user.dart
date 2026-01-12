

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/use_cases.dart';
import 'package:blog_app/core/common/entity/user_entity.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class Currentuser implements UseCases<UserEntity, NoParams> {
  final AuthRepository repository;

  Currentuser(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return  await repository.currentUser();
  }
}