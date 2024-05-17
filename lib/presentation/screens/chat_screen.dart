import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';
import 'package:skill_share/constants/decoration.dart';
import 'dart:async';
import 'package:skill_share/data/models/chat.dart';
import 'package:skill_share/data/repositories/chat_repository.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  final Chat chat;

  const ChatScreen({super.key, required this.chat});
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final scrollController = ScrollController();
  final messageController = TextEditingController();
  late String textMessage;
  String prevMsg = 'noUser';

  void scrollToBottom() {
    Timer timer = Timer(const Duration(seconds: 1), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.hasClients ? scrollToBottom() : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userEmail =
        (context.read<AuthenticationBloc>().state as Authenticated).user.email;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: null,
        title: Text(
          'Direct Message',
          style: titleStyle,
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'images/chatbkg.jpeg'), // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                  stream: ChatRepository.getMessages(chat: widget.chat),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      // scrollToBottom();
                      var documents = snapshot.data!.docs;
                      List<MessageBubble> MessageBubbles = [];
                      for (var doc in documents) {
                        var message = doc['message'];
                        var sender = doc['sender'];
                        var messageBubble = MessageBubble(
                          sender: sender,
                          message: message,
                          isMe: sender == userEmail,
                          sameLastSender: sender == prevMsg,
                        );
                        MessageBubbles.add(messageBubble);
                        prevMsg = doc['sender'];
                      }
                      return Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          children: MessageBubbles,
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: 8 + MediaQuery.of(context).viewInsets.bottom,
                      top: 3),
                  child: Material(
                    color: const Color(0xFF272727), //Color(0xff3e4785),
                    borderRadius: BorderRadius.circular(23),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              onChanged: (value) {
                                textMessage = value;
                                //Do something with the user input.
                              },
                              style: const TextStyle(
                                color: Color.fromARGB(255, 224, 215, 214),
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Message...',
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 186, 186, 186),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {
                              scrollController.animateTo(
                                scrollController.position.maxScrollExtent,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeOut,
                              );
                              messageController.clear();
                              // _firestore.collection('messages').add({
                              //   'text': textMessage,
                              //   'sender': loggedInUser.email,
                              //   'timestamp': FieldValue.serverTimestamp(),
                              // });
                              ChatRepository.addMessage(
                                  chat: widget.chat,
                                  message: textMessage,
                                  email: userEmail);
                              //Implement send functionality.
                            },
                            // color: Color.fromARGB(255, 0, 2, 7),
                            // minWidth: 0,
                            shape: const CircleBorder(),
                            child: const Icon(
                              Icons.send,
                              color: Color(0xFFfb542b),
                            ),
                            // child: Material(
                            //   color: Color(0xffDBE6FC),
                            //   borderRadius: BorderRadius.circular(10),
                            //   child: Icon(IconData(0xf355, fontFamily: 'MaterialIcons', matchTextDirection: true),size: 35,),
                            // ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message, sender;
  final bool isMe, sameLastSender;
  const MessageBubble(
      {super.key,
      required this.message,
      required this.sender,
      required this.isMe,
      required this.sameLastSender});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          !sameLastSender
              ? Text(
                  sender,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color.fromARGB(255, 224, 215, 214),
                  ),
                )
              : Container(),
          Material(
            elevation: 5.0,
            borderRadius: sameLastSender
                ? BorderRadius.circular(20)
                : isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))
                    : const BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
            color: isMe
                ? const Color.fromARGB(255, 26, 26, 26)
                : const Color(0xFF272727),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 15.0,
                    color: isMe
                        ? const Color(0xffffffff) //Color(0xffDBE6FC)
                        : const Color(0xffffffff) //Color(0xff3e4785)),
                    // textAlign: sender == loggedInUser.email
                    //     ? TextAlign.right
                    //     : TextAlign.left,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
