import 'dart:convert';

import 'package:flutter/foundation.dart';

class Community {
  final String name;
  final bool is_admin;
  final bool is_member;
  final Skill skill;
  final List<dynamic> members;
  Community({
    required this.name,
    required this.is_admin,
    required this.is_member,
    required this.skill,
    required this.members,
  });

  Community copyWith({
    String? name,
    bool? is_admin,
    bool? is_member,
    Skill? skill,
    List<dynamic>? members,
  }) {
    return Community(
      name: name ?? this.name,
      is_admin: is_admin ?? this.is_admin,
      is_member: is_member ?? this.is_member,
      skill: skill ?? this.skill,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'is_admin': is_admin,
      'is_member': is_member,
      'skill': skill.toMap(),
      'members': members,
    };
  }

  factory Community.fromMap(Map<String, dynamic> map) {
    return Community(
      name: map['name'] as String,
      is_admin: map['is_admin'] as bool,
      is_member: map['is_member'] as bool,
      skill: Skill.fromMap(map['skill'] as Map<String, dynamic>),
      members: List<dynamic>.from((map['members'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Community.fromJson(String source) =>
      Community.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Community(name: $name, is_admin: $is_admin, is_member: $is_member, skill: $skill, members: $members)';
  }

  @override
  bool operator ==(covariant Community other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.is_admin == is_admin &&
        other.is_member == is_member &&
        other.skill == skill &&
        listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        is_admin.hashCode ^
        is_member.hashCode ^
        skill.hashCode ^
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

  factory Skill.fromJson(String source) =>
      Skill.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Skill(id: $id, name: $name)';

  @override
  bool operator ==(covariant Skill other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
