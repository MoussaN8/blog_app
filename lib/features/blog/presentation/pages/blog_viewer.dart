import 'package:blog_app/core/utils/calculate_reading.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BlogViewer extends StatelessWidget {
  final BlogEntity blog;
  const BlogViewer({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blog.titre,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const SizedBox(height: 40),
              Text(
                "par ${blog.posterName}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),

              Text(
                'Publié le ${DateFormat('dd MMM yyyy à HH:mm').format(blog.createdAt)} . ${calculateReadingTime(blog.contenu)} min',
              ),
              const SizedBox(height: 30),
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(12),
                child: Image.network(blog.imageUrl),
              ),
              //contenu
              const SizedBox(height: 30),
              Text(blog.contenu, style: TextStyle(height: 2)),
            ],
          ),
        ),
      ),
    );
  }
}
