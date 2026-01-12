import 'dart:io';

import 'package:blog_app/core/usecases/use_cases.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlogUseCase uploadBlogUseCase;
  final GetAllBlogsUseCase getAllBlogsUseCase;
  BlogBloc(this.uploadBlogUseCase, this.getAllBlogsUseCase) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlogEvent>(_uploadBlogEvent);
    on<GetBlogEvent>(_getBlogEvent);
  }
  void _uploadBlogEvent(UploadBlogEvent event, Emitter<BlogState> emit) async {
    final resultat = await uploadBlogUseCase(
      UploadBlogParams(
        titre: event.titre,
        contenu: event.contenu,
        imageUrl: event.imageUrl,
        userId: event.userId,
        theme: event.theme,
      ),
    );
    resultat.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit(BlogSuccess()),
    );
  }

  void _getBlogEvent(GetBlogEvent event, Emitter<BlogState> emit) async {
    final res = await getAllBlogsUseCase(NoParams());
    res.fold(
      (l) => emit(BlogFailure(l.message)),
      (r) => emit((BlogDisplaySuccess(r))),
    );
  }
}
