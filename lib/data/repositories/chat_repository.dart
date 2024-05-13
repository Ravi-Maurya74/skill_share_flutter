// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skill_share/constants/constants.dart';

import 'package:skill_share/data/models/chat.dart';

class ChatRepository {
  static Future<Chat> createChat(
      {required String type,
      String name = '',
      required List<String> participants}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String idToken = prefs.getString('idToken')!;
      Response response = await Dio().post(
        ChatApiConstants.listCreateChat,
        data: {
          'type': type,
          'name': name,
          'participants': participants,
        },
        options: Options(
          headers: {
            'Authorization': 'Token $idToken',
          },
        ),
      );
      return Chat.fromMap(response.data);
    } on Exception catch (e) {
      debugPrint('Failed to create chat: $e');
      rethrow;
    }
  }

  static Stream<QuerySnapshot> getMessages({required Chat chat}) {
    return FirebaseFirestore.instance
        .collection('chats')
        .doc(chat.document_id)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  static addMessage({required Chat chat, required String message,required String email}) async {
    try {
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chat.document_id)
          .collection('messages')
          .add({
        'sender': email,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } on Exception catch (e) {
      debugPrint('Failed to add message: $e');
      rethrow;
    }
  }
}
