import 'dart:convert';

class User {
  final String uid;
  final String name;
  final String email;
  final String picture;
  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.picture,
  });

  User copyWith({
    String? uid,
    String? name,
    String? email,
    String? picture,
  }) {
    return User(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      picture: picture ?? this.picture,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'picture': picture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      picture: map['picture'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email, picture: $picture)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.name == name &&
      other.email == email &&
      other.picture == picture;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      picture.hashCode;
  }
}