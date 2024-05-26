import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/saved_posts/saved_posts_bloc.dart';
import 'package:skill_share/presentation/widgets/list_post_card.dart';

class SavedPostsScreen extends StatelessWidget {
  const SavedPostsScreen({super.key});

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
      body: BlocBuilder<SavedPostsBloc, SavedPostsState>(
        builder: (context, state) {
          if (state is SavedPostsInitial || state is SavedPostsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SavedPostsLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                return ListPostCard(post: state.posts[index], showJoinedButton: true);
              },
            );
          } else{
            return Center(
              child: Text((state as SavedPostsError).message),
            );}
        },
      )
    );
  }
}
