

import 'package:blog_app/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {

  UserModel({
    required super.id,
    required super.name,
    required super.email
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {

    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );

  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

}