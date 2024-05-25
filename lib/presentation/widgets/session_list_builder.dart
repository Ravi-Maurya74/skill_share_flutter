import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/list_session/list_session_bloc.dart';
import 'package:skill_share/data/models/community.dart';

class SessionListBuilder extends StatelessWidget {
  const SessionListBuilder({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListSessionBloc,ListSessionState>(bloc: ListSessionBloc(community.name),builder: (context, state) {
      if (state is ListSessionLoading || state is ListSessionInitial) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is ListSessionLoaded) {
        return ListView.builder(
          itemCount: state.sessions.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(state.sessions[index].description),
            subtitle: Text(state.sessions[index].time),
          )
        );
      } else {
        print((state as ListSessionError).message);
        return const Center(child: Text('An error occurred'));
      }
    });
  }
}