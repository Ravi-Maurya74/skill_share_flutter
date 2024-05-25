import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/list_session/list_session_bloc.dart';
import 'package:skill_share/data/models/community.dart';
import 'package:skill_share/data/models/list_session.dart';
import 'package:skill_share/presentation/screens/SessionScreen.dart';

class SessionListBuilder extends StatelessWidget {
  const SessionListBuilder({super.key, required this.community});
  final Community community;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListSessionBloc, ListSessionState>(
        bloc: ListSessionBloc(community.name),
        builder: (context, state) {
          if (state is ListSessionLoading || state is ListSessionInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListSessionLoaded) {
            return ListView.builder(
                itemCount: state.sessions.length,
                itemBuilder: (context, index) =>
                    SingleListSessionWidget(session: state.sessions[index]));
          } else {
            print((state as ListSessionError).message);
            return const Center(child: Text('An error occurred'));
          }
        });
  }
}

class SingleListSessionWidget extends StatelessWidget {
  const SingleListSessionWidget({
    super.key,
    required this.session,
  });

  final ListSession session;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionScreen(session: session),
            ));
      },
      title: Text(session.description),
      subtitle: Text(session.time),
    );
  }
}
