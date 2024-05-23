
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/list_post/list_post_bloc.dart';
import 'package:skill_share/presentation/widgets/list_post_card.dart';

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
            itemBuilder: (context, index) => ListPostCard(
              post: state.posts[index],
              showJoinedButton: showJoinedButton,
            ),
          );
        } else {
          print((state as ListPostError).message);
          return const Center(child: Text('An error occurred'));
        }
      },
    );
  }
}

