import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/detail_post/detail_post_bloc.dart';
import 'package:skill_share/presentation/widgets/comments.dart';
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Post(showJoinedButton: showJoinedButton),
              BlocBuilder<DetailPostBloc, DetailPostState>(
                builder: (context, state) {
                  if (state is DetailPostLoaded) {
                    return Comments(
                      post: state.post.id,
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
