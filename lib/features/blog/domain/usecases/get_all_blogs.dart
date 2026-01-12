import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/use_cases.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllBlogsUseCase implements UseCases<List<BlogEntity>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogsUseCase(this.blogRepository);
  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async{
   return await  blogRepository.getAllBlogs();
  }
}
