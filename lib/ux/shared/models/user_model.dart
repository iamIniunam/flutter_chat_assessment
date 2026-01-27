import 'package:flutter_chat_assessment/platform/data_source/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    super.isOnline,
    super.lastSeen,
  });

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      avatarUrl: user.avatarUrl,
      isOnline: user.isOnline,
      lastSeen: user.lastSeen,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      isOnline: (json['is_online'] ?? 0) == 1,
      lastSeen: json['last_seen'] != null
          ? (json['last_seen'] is int
              ? DateTime.fromMillisecondsSinceEpoch(json['last_seen'] as int)
              : DateTime.tryParse(json['last_seen'].toString()))
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
      'is_online': isOnline ? 1 : 0,
      'last_seen': lastSeen?.millisecondsSinceEpoch,
    };
  }
}
