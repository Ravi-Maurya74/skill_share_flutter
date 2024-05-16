import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/list_post/list_post_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder(
      bloc: ListPostBloc(),
      builder: (context, state) {
        if (state is ListPostLoading || state is ListPostInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListPostLoaded) {
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(state.posts[index].title),
                subtitle: Text(state.posts[index].content),
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) =>
                  //         StreamingScreen(post: state.posts[index])));
                },
              );
            },
          );
        } else {
          print((state as ListPostError).message);
          return const Center(child: Text('An error occurred'));
        }
      },
    ));
  }
}
