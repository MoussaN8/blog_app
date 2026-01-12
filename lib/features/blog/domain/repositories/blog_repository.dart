import 'dart:io';

import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String titre,
    required String contenu,
    required String userId,
    required String theme,
    required DateTime createdAt
  });
  Future <Either<Failure, List <BlogEntity>>> getAllBlogs();
}
