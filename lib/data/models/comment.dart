import 'dart:convert';

import 'package:skill_share/data/models/user.dart';

class Comment {
  final int id;
  final User user;
  final int upvotes;
  final int downvotes;
  final int score;
  final int? vote;
  final String content;
  final String created_at;
  final String updated_at;
  final int depth;
  final int post;
  final int? parent;
  Comment({
    required this.id,
    required this.user,
    required this.upvotes,
    required this.downvotes,
    required this.score,
    this.vote,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.depth,
    required this.post,
    this.parent,
  });

  Comment copyWith({
    int? id,
    User? user,
    int? upvotes,
    int? downvotes,
    int? score,
    int? vote,
    String? content,
    String? created_at,
    String? updated_at,
    int? depth,
    int? post,
    int? parent,
  }) {
    return Comment(
      id: id ?? this.id,
      user: user ?? this.user,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      score: score ?? this.score,
      vote: vote ?? this.vote,
      content: content ?? this.content,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      depth: depth ?? this.depth,
      post: post ?? this.post,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': user.toMap(),
      'upvotes': upvotes,
      'downvotes': downvotes,
      'score': score,
      'vote': vote,
      'content': content,
      'created_at': created_at,
      'updated_at': updated_at,
      'depth': depth,
      'post': post,
      'parent': parent,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'].toInt() as int,
      user: User.fromMap(map['user'] as Map<String,dynamic>),
      upvotes: map['upvotes'].toInt() as int,
      downvotes: map['downvotes'].toInt() as int,
      score: map['score'].toInt() as int,
      vote: map['vote'] as int?,
      content: map['content'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      depth: map['depth'].toInt() as int,
      post: map['post'].toInt() as int,
      parent: map['parent'] as int?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(id: $id, user: $user, upvotes: $upvotes, downvotes: $downvotes, score: $score, vote: $vote, content: $content, created_at: $created_at, updated_at: $updated_at, depth: $depth, post: $post, parent: $parent)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.user == user &&
      other.upvotes == upvotes &&
      other.downvotes == downvotes &&
      other.score == score &&
      other.vote == vote &&
      other.content == content &&
      other.created_at == created_at &&
      other.updated_at == updated_at &&
      other.depth == depth &&
      other.post == post &&
      other.parent == parent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user.hashCode ^
      upvotes.hashCode ^
      downvotes.hashCode ^
      score.hashCode ^
      vote.hashCode ^
      content.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      depth.hashCode ^
      post.hashCode ^
      parent.hashCode;
  }
}

