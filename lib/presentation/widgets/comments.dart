import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/comments_bloc/comments_bloc.dart';
import 'package:skill_share/constants/decoration.dart';
import 'package:skill_share/data/models/comment.dart';
import 'package:skill_share/presentation/widgets/create_comment.dart';
import 'package:skill_share/presentation/widgets/user_profile_pic.dart';

class Comments extends StatelessWidget {
  const Comments({super.key, required this.post, this.parent});
  final int post;
  final int? parent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentsBloc, CommentsState>(
      builder: (context, state) {
        if (state is CommentsLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CommentWidget(
                key: ValueKey(state.comments[index].id),
                comment: state.comments[index],
              );
            },
            itemCount: state.comments.length,
          );
        } else if (state is CommentsError) {
          return Center(child: Text(state.error));
        } else {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator()),
            ),
          );
        }
      },
      bloc: CommentsBloc(post, parent),
    );
  }
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key, required this.comment});
  final Comment comment;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Colors.grey, width: 1)),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            enableFeedback: true,
            dense: true,
            isThreeLine: true,
            selected: showComments,
            onTap: () {
              setState(() {
                showComments = !showComments;
              });
            },
            titleAlignment: ListTileTitleAlignment.top,
            leading: UserProfilePic(
              url: widget.comment.user.picture,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.comment.user.name,
                  style: bodyStyle,
                ),
                Text(
                  widget.comment.user.email,
                  style: bodyStyle.copyWith(
                      fontSize:
                          Theme.of(context).textTheme.bodySmall!.fontSize),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.comment.content,
                  textAlign: TextAlign.justify,
                  // style: readingStyle.copyWith(
                  //     fontSize:
                  //         Theme.of(context).textTheme.bodySmall!.fontSize! + 2),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CreateCommentWidget(
                      post: widget.comment.post,
                      parent: widget.comment.id,
                      onCreateComment: () {
                        setState(() {
                          showComments = false;
                        });
                      },
                    ),
                    // TODO
                    // Text('reply',style: Theme.of(context).textTheme.bodySmall,),
                    // BlocProvider(
                    //   create: (context) => SingleCommentBloc(
                    //       authToken: context.read<AuthCubit>().state.authToken!,
                    //       dio: Dio(),
                    //       comment: widget.comment),
                    //   child: const CommentActivity(),
                    // ),
                  ],
                ),
              ],
            ),
            // trailing: IconButton(
            //   onPressed: () {
            //     setState(() {
            //       showComments = !showComments;
            //     });
            //   },
            //   icon: const Icon(Icons.comment),
            // ),
          ),
        ),
        if (showComments)
          Padding(
            padding: EdgeInsets.only(left: widget.comment.depth > 4 ? 0 : 15),
            child: Comments(
                post: widget.comment.post, parent: widget.comment.id),
          ),
      ],
    );
  }
}

// class CreateCommentWidget extends StatelessWidget {
//   const CreateCommentWidget(
//       {super.key,
//       required this.commentId,
//       required this.postId,
//       required this.onCreateComment});

//   final int postId;
//   final int commentId;
//   final VoidCallback onCreateComment;

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//         icon: const Icon(Icons.reply),
//         onPressed: () {
//           showDialog(
//               context: context,
//               builder: (_) {
//                 return BlocProvider(
//                   create: (context) => CommentCreateBloc(
//                       authToken: context.read<AuthCubit>().state.authToken!,
//                       dio: Dio(),
//                       commentId: commentId,
//                       postId: postId),
//                   child: BlocBuilder<CommentCreateBloc, CommentCreateState>(
//                     builder: (context, state) {
//                       if (state is CommentCreateInitial) {
//                         return CreateCommentDialog(
//                           commentController: TextEditingController(),
//                           commentCreateBloc: context.read<CommentCreateBloc>(),
//                           onCreateComment: onCreateComment,
//                         );
//                       } else if (state is CommentCreateLoading) {
//                         return const AlertDialog(
//                           title: Text('Create Comment'),
//                           content: SizedBox(
//                             height: 30,
//                             width: 20,
//                             child: Center(
//                               child: CircularProgressIndicator(),
//                             ),
//                           ),
//                         );
//                       } else if (state is CommentCreateLoaded) {
//                         return AlertDialog(
//                           title: const Text('Create Comment'),
//                           content: Text(commentId == 0
//                               ? 'Comment Added. Your comment will be visible next time you visit this post.'
//                               : 'Reply added.'),
//                               actions: [
//                                 TextButton(onPressed: (){
//                                   Navigator.pop(context);
//                                 }, child: const Text('Ok'))
//                               ],
//                         );
//                       } else {
//                         return const AlertDialog(
//                           title: Text('Create Comment'),
//                           content:
//                               Text('Something went wrong. Please try again.'),
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//               barrierDismissible: false);
//         });
//   }
// }

// class CreateCommentDialog extends StatelessWidget {
//   const CreateCommentDialog(
//       {super.key,
//       required this.onCreateComment,
//       required this.commentCreateBloc,
//       required this.commentController});

//   final VoidCallback onCreateComment;
//   final TextEditingController commentController;
//   final CommentCreateBloc commentCreateBloc;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Create Comment'),
//       content: TextField(
//         controller: commentController,
//         decoration: const InputDecoration(hintText: 'Enter your comment here'),
//       ),
//       actions: [
//         TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('Cancel')),
//         TextButton(
//             onPressed: () {
//               commentCreateBloc.add(CommentCreateEvent(
//                   onCommentCreate: onCreateComment,
//                   content: commentController.text));
//             },
//             child: const Text('Create')),
//       ],
//     );
//   }
// }
