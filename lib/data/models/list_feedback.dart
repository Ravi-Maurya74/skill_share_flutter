import 'dart:convert';

class ListFeedback {
  final int id;
  final int rating;
  final String comments;
  final String user;
  final int session;
  ListFeedback({
    required this.id,
    required this.rating,
    required this.comments,
    required this.user,
    required this.session,
  });

  ListFeedback copyWith({
    int? id,
    int? rating,
    String? comments,
    String? user,
    int? session,
  }) {
    return ListFeedback(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      comments: comments ?? this.comments,
      user: user ?? this.user,
      session: session ?? this.session,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'rating': rating,
      'comments': comments,
      'user': user,
      'session': session,
    };
  }

  factory ListFeedback.fromMap(Map<String, dynamic> map) {
    return ListFeedback(
      id: map['id'].toInt() as int,
      rating: map['rating'].toInt() as int,
      comments: map['comments'] as String,
      user: map['user'] as String,
      session: map['session'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListFeedback.fromJson(String source) => ListFeedback.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ListFeedback(id: $id, rating: $rating, comments: $comments, user: $user, session: $session)';
  }

  @override
  bool operator ==(covariant ListFeedback other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.rating == rating &&
      other.comments == comments &&
      other.user == user &&
      other.session == session;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      rating.hashCode ^
      comments.hashCode ^
      user.hashCode ^
      session.hashCode;
  }
}