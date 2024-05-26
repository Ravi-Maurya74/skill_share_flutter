import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/detail_post/detail_post_bloc.dart';
import 'package:skill_share/data/models/list_post.dart';
import 'package:skill_share/presentation/screens/post_detail_screen.dart';
import 'package:skill_share/presentation/widgets/join_button.dart';

class ListPostCard extends StatelessWidget {
  const ListPostCard({
    super.key,
    required this.post,
    required this.showJoinedButton,
  });

  final ListPost post;
  final bool showJoinedButton;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlocProvider<DetailPostBloc>(
                  create: (context) => DetailPostBloc(post.id.toString()),
                  child: PostDetailScreen(showJoinedButton: showJoinedButton),
                )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF272727),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              visualDensity: VisualDensity.compact,
              contentPadding: const EdgeInsets.all(0),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(post.user.picture),
              ),
              title: Row(
                children: [
                  Text('${post.user.name} '), //• ${post.created_at}
                ],
              ),
              // Text(post.user.name),
              subtitle: Text(post.community.name),
              trailing: (showJoinedButton && !post.community.is_member) ? const JoinButton() : null,
              // onTap: () {
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (context) => BlocProvider<DetailPostBloc>(
              //             create: (context) => DetailPostBloc(post.id.toString()),
              //             child: const PostDetailScreen(),
              //           )));
              // },
            ),
            Text(
              post.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            if (post.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  post.image!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),
            const SizedBox(
              height: 4,
            ),
            Text(
                '${post.content.substring(0, min(100, post.content.length))}...'),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 6, 4, 6),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF272727),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(22.0),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_circle_up_rounded,
                        size: 16,
                        color: Color.fromARGB(255, 208, 207, 207),
                      ),
                      Text(' ${post.score.toString()} '),
                    ],
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
