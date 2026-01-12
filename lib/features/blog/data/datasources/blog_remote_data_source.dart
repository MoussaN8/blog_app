import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadImage(File image, BlogModel blogModel);
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final response = await supabaseClient
          .from('blogs')
          .insert(blogModel.toJson())
          .select()
          .single();
      return BlogModel.fromJson(response);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // upload de l'image
  @override
  Future<String> uploadImage(File image, BlogModel blog) async {
    try {
      // Nom du fichier basé sur id du blog
      final fileName = '${blog.id}.jpg';

      // upload de l'image
      await supabaseClient.storage.from('images_blogs').upload(fileName, image);

      // récupération de l'url publique
      return supabaseClient.storage.from('images_blogs').getPublicUrl(fileName);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // implémentation de la méthode getAllBlogs

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*, profiles(name)');
          return blogs.map((blog)=>BlogModel.fromJson(blog).copyWith(posterName: blog['profiles']['name'])).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
