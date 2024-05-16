import 'dart:convert';

import 'package:skill_share/data/models/user.dart';

class ListPost {
  final int id;
  final User user;
  final int score;
  final int vote;
  final String title;
  final String content;
  final String? image; // Make image nullable
  final String created_at;
  final String updated_at;
  final String community;
  ListPost({
    required this.id,
    required this.user,
    required this.score,
    required this.vote,
    required this.title,
    required this.content,
    this.image, // Update image declaration
    required this.created_at,
    required this.updated_at,
    required this.community,
  });

  ListPost copyWith({
    int? id,
    User? user,
    int? score,
    int? vote,
    String? title,
    String? content,
    String? image,
    String? created_at,
    String? updated_at,
    String? community,
  }) {
    return ListPost(
      id: id ?? this.id,
      user: user ?? this.user,
      score: score ?? this.score,
      vote: vote ?? this.vote,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      community: community ?? this.community,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'score': score,
      'vote': vote,
      'title': title,
      'content': content,
      'image': image, // Update image mapping
      'created_at': created_at,
      'updated_at': updated_at,
      'community': community,
    };
  }

  factory ListPost.fromMap(Map<String, dynamic> map) {
    return ListPost(
      id: map['id'].toInt() as int,
      user: User.fromMap(map['user'] as Map<String,dynamic>),
      score: map['score'].toInt() as int,
      vote: map['vote'].toInt() as int,
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] as String?, // Update image parsing
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      community: map['community'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListPost.fromJson(String source) => ListPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ListPost(id: $id, user: $user, score: $score, vote: $vote, title: $title, content: $content, image: $image, created_at: $created_at, updated_at: $updated_at, community: $community)';
  }

  @override
  bool operator ==(covariant ListPost other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.user == user &&
      other.score == score &&
      other.vote == vote &&
      other.title == title &&
      other.content == content &&
      other.image == image &&
      other.created_at == created_at &&
      other.updated_at == updated_at &&
      other.community == community;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user.hashCode ^
      score.hashCode ^
      vote.hashCode ^
      title.hashCode ^
      content.hashCode ^
      image.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      community.hashCode;
  }
}
