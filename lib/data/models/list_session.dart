import 'dart:convert';

class ListSession {
  final int id;
  final String channel_id;
  final String time;
  final String description;
  final int duration;
  final String community;
  ListSession({
    required this.id,
    required this.channel_id,
    required this.time,
    required this.description,
    required this.duration,
    required this.community,
  });

  ListSession copyWith({
    int? id,
    String? channel_id,
    String? time,
    String? description,
    int? duration,
    String? community,
  }) {
    return ListSession(
      id: id ?? this.id,
      channel_id: channel_id ?? this.channel_id,
      time: time ?? this.time,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      community: community ?? this.community,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'channel_id': channel_id,
      'time': time,
      'description': description,
      'duration': duration,
      'community': community,
    };
  }

  factory ListSession.fromMap(Map<String, dynamic> map) {
    return ListSession(
      id: map['id'].toInt() as int,
      channel_id: map['channel_id'] as String,
      time: map['time'] as String,
      description: map['description'] as String,
      duration: map['duration'].toInt() as int,
      community: map['community'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListSession.fromJson(String source) => ListSession.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ListSession(id: $id, channel_id: $channel_id, time: $time, description: $description, duration: $duration, community: $community)';
  }

  @override
  bool operator ==(covariant ListSession other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.channel_id == channel_id &&
      other.time == time &&
      other.description == description &&
      other.duration == duration &&
      other.community == community;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      channel_id.hashCode ^
      time.hashCode ^
      description.hashCode ^
      duration.hashCode ^
      community.hashCode;
  }
}