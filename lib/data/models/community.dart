import 'dart:convert';

import 'package:flutter/foundation.dart';

class Community {
  final String name;
  final bool is_admin;
  final bool is_member;
  final Skill skill;
  final String description;
  final String banner;
  final String profile_image;
  final List<String> members;
  Community({
    required this.name,
    required this.is_admin,
    required this.is_member,
    required this.skill,
    required this.description,
    required this.banner,
    required this.profile_image,
    required this.members,
  });

  Community copyWith({
    String? name,
    bool? is_admin,
    bool? is_member,
    Skill? skill,
    String? description,
    String? banner,
    String? profile_image,
    List<String>? members,
  }) {
    return Community(
      name: name ?? this.name,
      is_admin: is_admin ?? this.is_admin,
      is_member: is_member ?? this.is_member,
      skill: skill ?? this.skill,
      description: description ?? this.description,
      banner: banner ?? this.banner,
      profile_image: profile_image ?? this.profile_image,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'is_admin': is_admin,
      'is_member': is_member,
      'skill': skill.toMap(),
      'description': description,
      'banner': banner,
      'profile_image': profile_image,
      'members': members,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      name: map['name'] as String,
      is_admin: map['is_admin'] as bool,
      is_member: map['is_member'] as bool,
      skill: Skill.fromMap(map['skill'] as Map<String,dynamic>),
      description: map['description'] as String,
      banner: map['banner'] as String,
      profile_image: map['profile_image'] as String,
      members: List<String>.from((map['members'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) => Community.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Community(name: $name, is_admin: $is_admin, is_member: $is_member, skill: $skill, description: $description, banner: $banner, profile_image: $profile_image, members: $members)';
  }

  @override
  bool operator ==(covariant Community other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.is_admin == is_admin &&
      other.is_member == is_member &&
      other.skill == skill &&
      other.description == description &&
      other.banner == banner &&
      other.profile_image == profile_image &&
      listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return name.hashCode ^
      is_admin.hashCode ^
      is_member.hashCode ^
      skill.hashCode ^
      description.hashCode ^
      banner.hashCode ^
      profile_image.hashCode ^
      members.hashCode;
  }
}

class Skill {
  final int id;
  final String name;
  Skill({
    required this.id,
    required this.name,
  });

  Skill copyWith({
    int? id,
    String? name,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Skill.fromJson(String source) => Skill.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Skill(id: $id, name: $name)';

  @override
  bool operator ==(covariant Skill other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}