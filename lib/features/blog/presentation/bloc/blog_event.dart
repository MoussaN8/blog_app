part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class UploadBlogEvent extends BlogEvent {
  final String titre;
  final String contenu;
  final File imageUrl;
  final String userId;
  final String theme;
  

  UploadBlogEvent({
    required this.titre,
    required this.contenu,
    required this.imageUrl,
    required this.userId,
    required this.theme,
    
  });
}
final class GetBlogEvent extends BlogEvent{}
