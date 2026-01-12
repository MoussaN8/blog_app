// ignore_for_file: public_member_api_docs, sort_constructors_first
class BlogEntity {
  final String id;
  final String titre;
  final String contenu;
  final String imageUrl;
  final String userId;
  final String theme;
  final String? posterName;
  final DateTime createdAt; 


  BlogEntity({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.imageUrl,
    required this.userId,
    required this.theme,
    this.posterName, required this.createdAt,
  });
}
