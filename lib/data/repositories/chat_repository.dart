// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skill_share/constants/constants.dart';

import 'package:skill_share/data/models/chat.dart';

class ChatRepository {
  Future<Chat> createChat(
      {required String type,
      String name = '',
      required List<String> participants}) async {
    try {
      Response response = await Dio().post(
        ChatApiConstants.createChat,
        data: {
          'type': type,
          'name': name,
          'participants': participants,
        },
      );
      return Chat.fromMap(response.data);
    } on Exception catch (e) {
      debugPrint('Failed to create chat: $e');
      rethrow;
    }
  }

  Stream<QuerySnapshot> getMessages({required Chat chat}) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chat.document_id)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }
}
