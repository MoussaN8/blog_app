
import 'package:blog_app/core/common/entity/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });
  factory UserModel.fromJson(Map<String,dynamic>map){
    return UserModel(
      id:map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

}