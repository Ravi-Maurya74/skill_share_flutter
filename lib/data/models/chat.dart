import 'dart:convert';

import 'package:flutter/foundation.dart';

class Chat {
  final String document_id;
  final String type;
  final String name;
  final String last_message_time;
  final List<String> participants;
  Chat({
    required this.document_id,
    required this.type,
    required this.name,
    required this.last_message_time,
    required this.participants,
  });

  Chat copyWith({
    String? document_id,
    String? type,
    String? name,
    String? last_message_time,
    List<String>? participants,
  }) {
    return Chat(
      document_id: document_id ?? this.document_id,
      type: type ?? this.type,
      name: name ?? this.name,
      last_message_time: last_message_time ?? this.last_message_time,
      participants: participants ?? this.participants,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'document_id': document_id,
      'type': type,
      'name': name,
      'last_message_time': last_message_time,
      'participants': participants,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      document_id: map['document_id'] as String,
      type: map['type'] as String,
      name: map['name'] as String,
      last_message_time: map['last_message_time'] as String,
      participants: List<String>.from((map['participants'] as List<String>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(document_id: $document_id, type: $type, name: $name, last_message_time: $last_message_time, participants: $participants)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;
  
    return 
      other.document_id == document_id &&
      other.type == type &&
      other.name == name &&
      other.last_message_time == last_message_time &&
      listEquals(other.participants, participants);
  }

  @override
  int get hashCode {
    return document_id.hashCode ^
      type.hashCode ^
      name.hashCode ^
      last_message_time.hashCode ^
      participants.hashCode;
  }
}