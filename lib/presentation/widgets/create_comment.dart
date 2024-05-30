import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/create_comment/create_comment_bloc.dart';

class CreateCommentWidget extends StatelessWidget {
  const CreateCommentWidget(
      {super.key,
      this.parent,
      required this.post,
      this.onCreateComment});

  final int post;
  final int? parent;
  final VoidCallback? onCreateComment;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.reply),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return BlocProvider(
                  create: (context) => CreateCommentBloc(),
                  child: BlocBuilder<CreateCommentBloc, CreateCommentState>(
                    builder: (context, state) {
                      if (state is CreateCommentInitial) {
                        return CreateCommentDialog(
                          commentController: TextEditingController(),
                          commentCreateBloc: context.read<CreateCommentBloc>(),
                          onCreateComment: onCreateComment,
                          parent: parent,
                          post: post,
                        );
                      } else if (state is CreateCommentLoading) {
                        return const AlertDialog(
                          title: Text('Create Comment'),
                          content: SizedBox(
                            height: 30,
                            width: 20,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      } else if (state is CreateCommentSuccess) {
                        return AlertDialog(
                          title: const Text('Create Comment'),
                          content: Text(parent == null
                              ? 'Comment Added. Your comment will be visible next time you visit this post.'
                              : 'Reply added.'),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: const Text('Ok'))
                              ],
                        );
                      } else {
                        return const AlertDialog(
                          title: Text('Create Comment'),
                          content:
                              Text('Something went wrong. Please try again.'),
                        );
                      }
                    },
                  ),
                );
              },
              barrierDismissible: false);
        });
  }
}

class CreateCommentDialog extends StatelessWidget {
  const CreateCommentDialog(
      {super.key,
      this.onCreateComment,
      required this.commentCreateBloc,
      required this.commentController, this.parent, required this.post});

  final VoidCallback? onCreateComment;
  final TextEditingController commentController;
  final CreateCommentBloc commentCreateBloc;
  final int? parent;
  final int post;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Comment'),
      content: TextField(
        controller: commentController,
        decoration: const InputDecoration(hintText: 'Enter your comment here'),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              commentCreateBloc.add(CreateComment(
                  post: post,
                  content: commentController.text,
                  parent: parent,
                  onCreateComment: onCreateComment
              ));
            },
            child: const Text('Create')),
      ],
    );
  }
}