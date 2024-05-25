import 'package:flutter/material.dart';
import 'package:skill_share/presentation/widgets/post.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key, required this.showJoinedButton});

  final bool showJoinedButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0f0f0f),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.7),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text('Post Detail'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Post(showJoinedButton: showJoinedButton),
            ],
          ),
        ),
      ),
    );
  }
}
