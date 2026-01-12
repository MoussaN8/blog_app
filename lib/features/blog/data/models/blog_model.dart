import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel({
    required super.id,
    required super.titre,
    required super.contenu,
    required super.imageUrl,
    required super.userId,
    required super.theme,
    super.posterName,
    required super.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titre': titre,
      'contenu': contenu,
      'image_url': imageUrl,
      'user_id': userId,
      'theme': theme,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as String,
      titre: json['titre'] as String,
      contenu: json['contenu'] as String,
      imageUrl: json['image_url'] as String,
      userId: json['user_id'] as String,
      theme: json['theme'] as String,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
  BlogModel copyWith({
    String? id,
    String? titre,
    String? contenu,
    String? imageUrl,
    String? userId,
    String? theme,
    DateTime? publishedDate,
    String? posterName,
    DateTime? createdAt,
  }) {
    return BlogModel(
      id: id ?? this.id,
      titre: titre ?? this.titre,
      contenu: contenu ?? this.contenu,
      imageUrl: imageUrl ?? this.imageUrl,
      userId: userId ?? this.userId,
      theme: theme ?? this.theme,
      posterName: posterName ?? this.posterName,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
