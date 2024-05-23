import 'dart:convert';

import 'package:skill_share/data/models/user.dart';

class DetailPost {
  final int id;
  final User user;
  final int upvotes;
  final int downvotes;
  final int score;
  final bool is_saved;
  final int? vote;  // maine kya kiya
  final String title;
  final String content;
  final String? image;
  final String created_at;
  final String updated_at;
  final String community;
  DetailPost({
    required this.id,
    required this.user,
    required this.upvotes,
    required this.downvotes,
    required this.score,
    required this.is_saved,
    this.vote,
    required this.title,
    required this.content,
    this.image,
    required this.created_at,
    required this.updated_at,
    required this.community,
  });

  DetailPost copyWith({
    int? id,
    User? user,
    int? upvotes,
    int? downvotes,
    int? score,
    bool? is_saved,
    int? vote,
    String? title,
    String? content,
    String? image,
    String? created_at,
    String? updated_at,
    String? community,
  }) {
    return DetailPost(
      id: id ?? this.id,
      user: user ?? this.user,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      score: score ?? this.score,
      is_saved: is_saved ?? this.is_saved,
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
      'upvotes': upvotes,
      'downvotes': downvotes,
      'score': score,
      'is_saved': is_saved,
      'vote': vote,
      'title': title,
      'content': content,
      'image': image,
      'created_at': created_at,
      'updated_at': updated_at,
      'community': community,
    };
  }

  factory DetailPost.fromMap(Map<String, dynamic> map) {
    return DetailPost(
      id: map['id'].toInt() as int,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      upvotes: map['upvotes'].toInt() as int,
      downvotes: map['downvotes'].toInt() as int,
      score: map['score'].toInt() as int,
      is_saved: map['is_saved'] as bool,
      vote: map['vote'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] as String?,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      community: map['community'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailPost.fromJson(String source) =>
      DetailPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DetailPost(id: $id, user: $user, upvotes: $upvotes, downvotes: $downvotes, score: $score, is_saved: $is_saved, vote: $vote, title: $title, content: $content, image: $image, created_at: $created_at, updated_at: $updated_at, community: $community)';
  }

  @override
  bool operator ==(covariant DetailPost other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.user == user &&
        other.upvotes == upvotes &&
        other.downvotes == downvotes &&
        other.score == score &&
        other.is_saved == is_saved &&
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
        upvotes.hashCode ^
        downvotes.hashCode ^
        score.hashCode ^
        is_saved.hashCode ^
        vote.hashCode ^
        title.hashCode ^
        content.hashCode ^
        image.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        community.hashCode;
  }
}
