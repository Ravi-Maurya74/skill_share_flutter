import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skill_share/data/models/list_post.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
              backgroundImage:
                  NetworkImage(post.user.picture),
            ),
            title: Text(post.user.name),
            subtitle: Text(post.community),
            trailing: showJoinedButton ? const JoinButton() : null,
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) =>
              //         StreamingScreen(post: state.posts[index])));
            },
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
          if(post.image != null)
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
              IconButton(
                  icon: const Icon(Icons.favorite), onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.comment), onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.share), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
