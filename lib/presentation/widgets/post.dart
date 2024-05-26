import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/detail_post/detail_post_bloc.dart';
import 'package:skill_share/presentation/widgets/join_button.dart';
import 'package:skill_share/presentation/widgets/post_loading.dart';

class Post extends StatelessWidget {
  const Post({
    super.key,
    required this.showJoinedButton,
  });

  final bool showJoinedButton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPostBloc, DetailPostState>(
      builder: (context, state) {
        if (state is DetailPostLoading || state is DetailPostInitial) {
          return const PostLoading();
        } else if (state is DetailPostLoaded) {
          final post = state.post;
          return Column(
            children: [
              Container(
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
                        backgroundImage: NetworkImage(state.post.user.picture),
                      ),
                      title: Row(
                        children: [
                          Text(
                              '${state.post.user.name} '), //• ${post.created_at}
                        ],
                      ),
                      // Text(post.user.name),
                      subtitle: Text(state.post.community.name),
                      trailing: (showJoinedButton && !post.community.is_member) ? const JoinButton() : null,
                      // onTap: () {
                      // TODO
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //       builder: (context) => BlocProvider<DetailPostBloc>(
                      //             create: (context) => DetailPostBloc(post.id.toString()),
                      //             child: const PostDetailScreen(),
                      //           )));
                      // },
                    ),
                    Text(
                      state.post.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    if (state.post.image != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          state.post.image!,
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(state.post.content),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (post.vote != null && post.vote == 1) {
                              context
                                  .read<DetailPostBloc>()
                                  .add(const RemoveVoteDetailPost());
                            } else {
                              context
                                  .read<DetailPostBloc>()
                                  .add(const VoteDetailPost(1));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 6, 4, 6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF272727),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_upward_rounded,
                                    size: 16,
                                    color: (post.vote != null && post.vote == 1)
                                        ? Color.fromARGB(255, 177, 52, 52)
                                        : Color.fromARGB(255, 230, 229, 229)),
                                Text(' ${state.post.upvotes.toString()} '),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (post.vote != null && post.vote == -1) {
                              context
                                  .read<DetailPostBloc>()
                                  .add(const RemoveVoteDetailPost());
                            } else {
                              context
                                  .read<DetailPostBloc>()
                                  .add(const VoteDetailPost(-1));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 6, 4, 6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF272727),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_downward_rounded,
                                    size: 16,
                                    color: (post.vote != null &&
                                            post.vote == -1)
                                        ? Color.fromARGB(255, 177, 52, 52)
                                        : Color.fromARGB(255, 230, 229, 229)),
                                Text(' ${state.post.downvotes.toString()} '),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 6, 4, 6),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF272727),
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.forum_rounded,
                                  size: 16,
                                  color: Color.fromARGB(255, 208, 207, 207),
                                ),
                                Text(' Comments '),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            context.read<DetailPostBloc>().add(
                                SaveDetailPost(save: !state.post.is_saved));
                          },
                          icon: Icon(
                            (context.read<DetailPostBloc>().state
                                        as DetailPostLoaded)
                                    .post
                                    .is_saved
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: Color.fromARGB(255, 230, 229, 229),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // ListTile(
              //   title: Text(
              //     state.post.title,
              //     style: Theme.of(context).textTheme.titleMedium,
              //   ),
              //   subtitle: Text(
              //     state.post.content,
              //     style: Theme.of(context).textTheme.bodyText1,
              //   ),
              // ),
            ],
          );
        } else {
          return Center(
              child: Text(
            (context.read<DetailPostBloc>().state as DetailPostError)
                .message
                .toString(),
          ));
        }
      },
    );
  }
}
