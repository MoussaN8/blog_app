import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecases/use_cases.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlogUseCase implements UseCases<BlogEntity, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlogUseCase({required this.blogRepository});
  @override
  Future<Either<Failure, BlogEntity>> call(UploadBlogParams params) async {
    try {
      return await blogRepository.uploadBlog(
        image: params.imageUrl,
        titre: params.titre,
        contenu: params.contenu,
        userId: params.userId,
        theme: params.theme,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}

class UploadBlogParams {
  final String titre;
  final String contenu;
  final File imageUrl;
  final String userId;
  final String theme;

  UploadBlogParams({
    required this.titre,
    required this.contenu,
    required this.imageUrl,
    required this.userId,
    required this.theme,
  });
}
