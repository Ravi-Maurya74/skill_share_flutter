// import 'package:flutter/material.dart';

// class Comments extends StatelessWidget {
//   const Comments({super.key, required this.postId, this.commentId = 0});
//   final int postId;
//   final int commentId;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CommentBloc, CommentBlocState>(
//       builder: (context, state) {
//         if (state is CommentBlocLoaded) {
//           return ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return CommentWidget(
//                 key: ValueKey(state.commentList[index].id),
//                 comment: state.commentList[index],
//               );
//             },
//             itemCount: state.commentList.length,
//           );
//         } else if (state is CommentBlocError) {
//           return Center(child: Text(state.error));
//         } else {
//           return const Center(
//               child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: SizedBox(
//                 height: 30, width: 30, child: CircularProgressIndicator()),
//           ));
//         }
//       },
//       bloc: CommentBloc(
//         authToken: context.read<AuthCubit>().state.authToken!,
//         dio: Dio(),
//         postId: postId,
//         commentId: commentId,
//       ),
//     );
//   }
// }