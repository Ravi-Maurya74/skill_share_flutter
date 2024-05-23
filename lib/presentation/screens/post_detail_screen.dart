import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/detail_post/detail_post_bloc.dart';

class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

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
                ListTile(
                  title: Text(
                    state.post.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    state.post.content,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
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
