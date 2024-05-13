import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:skill_share/data/models/user.dart';

class Chat {
  final String document_id;
  final List<User> participants;
  final String type;
  final String name;
  final String last_message_time;
  Chat({
    required this.document_id,
    required this.participants,
    required this.type,
    required this.name,
    required this.last_message_time,
  });

  Chat copyWith({
    String? document_id,
    List<User>? participants,
    String? type,
    String? name,
    String? last_message_time,
  }) {
    return Chat(
      document_id: document_id ?? this.document_id,
      participants: participants ?? this.participants,
      type: type ?? this.type,
      name: name ?? this.name,
      last_message_time: last_message_time ?? this.last_message_time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'document_id': document_id,
      'participants': participants.map((x) => x.toMap()).toList(),
      'type': type,
      'name': name,
      'last_message_time': last_message_time,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      document_id: map['document_id'] as String,
      participants:
          List<User>.from(map['participants']?.map((x) => User.fromMap(x))),
      type: map['type'] as String,
      name: map['name'] as String,
      last_message_time: map['last_message_time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(document_id: $document_id, participants: $participants, type: $type, name: $name, last_message_time: $last_message_time)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.document_id == document_id &&
        listEquals(other.participants, participants) &&
        other.type == type &&
        other.name == name &&
        other.last_message_time == last_message_time;
  }

  @override
  int get hashCode {
    return document_id.hashCode ^
        participants.hashCode ^
        type.hashCode ^
        name.hashCode ^
        last_message_time.hashCode;
  }
}

// class Participant {
//   final String uid;
//   final String name;
//   final String email;
//   final String picture;
//   Participant({
//     required this.uid,
//     required this.name,
//     required this.email,
//     required this.picture,
//   });

//   Participant copyWith({
//     String? uid,
//     String? name,
//     String? email,
//     String? picture,
//   }) {
//     return Participant(
//       uid: uid ?? this.uid,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       picture: picture ?? this.picture,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'uid': uid,
//       'name': name,
//       'email': email,
//       'picture': picture,
//     };
//   }

//   factory Participant.fromMap(Map<String, dynamic> map) {
//     return Participant(
//       uid: map['uid'] as String,
//       name: map['name'] as String,
//       email: map['email'] as String,
//       picture: map['picture'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Participant.fromJson(String source) => Participant.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Participant(uid: $uid, name: $name, email: $email, picture: $picture)';
//   }

//   @override
//   bool operator ==(covariant Participant other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.uid == uid &&
//       other.name == name &&
//       other.email == email &&
//       other.picture == picture;
//   }

//   @override
//   int get hashCode {
//     return uid.hashCode ^
//       name.hashCode ^
//       email.hashCode ^
//       picture.hashCode;
//   }
// }