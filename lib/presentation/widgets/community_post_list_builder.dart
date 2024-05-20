import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/list_post/list_post_bloc.dart';
import 'package:skill_share/presentation/widgets/join_button.dart';

class CommunityPostListBuilder extends StatelessWidget {
  const CommunityPostListBuilder(
      {super.key, this.query, this.showJoinedButton = false});
  final String? query;
  final bool showJoinedButton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: ListPostBloc(query),
      builder: (context, state) {
        if (state is ListPostLoading || state is ListPostInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListPostLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
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
                            NetworkImage(state.posts[index].user.picture),
                      ),
                      title: Text(state.posts[index].user.name),
                      subtitle: Text(state.posts[index].community),
                      trailing: showJoinedButton ? const JoinButton() : null,
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         StreamingScreen(post: state.posts[index])));
                      },
                    ),
                    Text(
                      state.posts[index].title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    if(state.posts[index].image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        state.posts[index].image!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                        '${state.posts[index].content.substring(0, min(100, state.posts[index].content.length))}...'),
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
            },
          );
        } else {
          print((state as ListPostError).message);
          return const Center(child: Text('An error occurred'));
        }
      },
    );
  }
}
