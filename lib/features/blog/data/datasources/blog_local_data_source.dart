import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDataSource {
  Future<void> uploadLocalBlog({required List<BlogModel> blogs});
  Future<List<BlogModel>> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;
  BlogLocalDataSourceImpl(this.box);

  @override
  Future<void> uploadLocalBlog({required List<BlogModel> blogs}) async {
    await box.clear(); // supprime les anciens blogs
    for (int i = 0; i < blogs.length; i++) {
      await box.put(i.toString(), blogs[i].toJson());
    }
  }

  @override
  Future<List<BlogModel>> loadBlogs() async {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      final data = box.get(i.toString());
      if (data != null) {
        blogs.add(BlogModel.fromJson(Map<String, dynamic>.from(data)));
      }
    }
    return blogs;
  }
}