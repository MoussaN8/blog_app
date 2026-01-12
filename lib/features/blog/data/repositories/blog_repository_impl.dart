import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/network/connection_checker.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/failure.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  final ConnectionChecker connectionChecker;
  final BlogLocalDataSource blogLocalDataSource;
  BlogRepositoryImpl({
    required this.blogRemoteDataSource,
    required this.connectionChecker,
    required this.blogLocalDataSource,
  });
  @override
  Future<Either<Failure, BlogEntity>> uploadBlog({
    required File image,
    required String titre,
    required String contenu,
    required String userId,
    required String theme,
    required DateTime createdAt,
  }) async {
    if (!await (connectionChecker.isconnected)) {
      return left(Failure("internet pas disponible"));
    }
    try {
      BlogModel blogModel = BlogModel(
        id: Uuid().v4(),
        titre: titre,
        contenu: contenu,
        imageUrl: '',
        userId: userId,
        theme: theme,
        createdAt: createdAt,
      );
      final imageUrl = await blogRemoteDataSource.uploadImage(image, blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);
      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  // implémentation de la méthode getAllBlogs

  @override
  Future<Either<Failure, List<BlogEntity>>> getAllBlogs() async {
    if (!await (connectionChecker.isconnected)) {
      final blogs = blogLocalDataSource.loadBlogs();
      return right(blogs as List<BlogEntity>);
    }
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      blogLocalDataSource.uploadLocalBlog(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
