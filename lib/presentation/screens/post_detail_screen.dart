import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/detail_post/detail_post_bloc.dart';
import 'package:skill_share/presentation/widgets/join_button.dart';

bool isBookmarked = false;

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({super.key, required this.showJoinedButton});

  final bool showJoinedButton;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
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
      body: BlocBuilder<DetailPostBloc, DetailPostState>(
        builder: (context, state) {
          if (state is DetailPostLoading || state is DetailPostInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailPostLoaded) {
            return Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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
                              NetworkImage(state.post.user.picture),
                        ),
                        title: Row(
                          children: [
                            Text(
                                '${state.post.user.name} '), //• ${post.created_at}
                          ],
                        ),
                        // Text(post.user.name),
                        subtitle: Text(state.post.community),
                        trailing:
                            widget.showJoinedButton ? const JoinButton() : null,
                        // onTap: () {
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
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_upward_rounded,
                                    size: 16,
                                    color: Color.fromARGB(255, 208, 207, 207),
                                  ),
                                  Text(' ${state.post.upvotes.toString()} '),
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
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.arrow_downward_rounded,
                                    size: 16,
                                    color: Color.fromARGB(255, 208, 207, 207),
                                  ),
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
                              setState(() {
                                isBookmarked =
                                    !isBookmarked; //iske change hone se ye pura build render hoga dobara na? not efficient?
                              });
                            },
                            icon: Icon(
                              isBookmarked
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: const Color.fromARGB(255, 230, 229, 229),
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
            return const Center(child: Text('An error occurred'));
          }
        },
      ),
    );
  }
}
