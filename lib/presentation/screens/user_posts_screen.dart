import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/user_posts_bloc/user_posts_bloc.dart';
import 'package:skill_share/presentation/widgets/list_post_card.dart';

class UserPostsScreen extends StatelessWidget {
  const UserPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Saved Posts',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
                fontSize: 19,
              ),
        ),
      ),
      body: BlocBuilder<UserPostsBloc, UserPostsState>(
        builder: (context, state) {
          if (state is UserPostsInitial || state is UserPostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserPostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return ListPostCard(post: state.posts[index], showJoinedButton: true);
              },
            );
          } else{
            return Center(
              child: Text((state as UserPostsError).message),
            );}
        },
      )
    );
  }
}
