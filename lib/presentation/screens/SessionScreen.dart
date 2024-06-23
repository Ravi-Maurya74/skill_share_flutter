import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/list_feedback/list_feedback_bloc.dart';
import 'package:skill_share/data/models/list_session.dart';
import 'package:skill_share/presentation/screens/create_new_session_screen.dart';
import 'package:skill_share/presentation/screens/streaming.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key, required this.session});
  final ListSession session;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sessions'),
        ),
        body: Center(
          child: Column(
            children: [
              Text(session.description,
                  style: Theme.of(context).textTheme.titleMedium!),
              Text(formatDateTime(DateTime.parse(session.time))),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoCallScreen(channelName: session.channel_id),
                      ));
                },
                child: const Text('Join Session'),
              ),
              FeedbackListWidget(
                session: session,
              ),
            ],
          ),
        ));
  }
}

class FeedbackListWidget extends StatelessWidget {
  const FeedbackListWidget({super.key, required this.session});
  final ListSession session;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListFeedbackBloc, ListFeedbackState>(
      bloc: ListFeedbackBloc(session),
      builder: (context, state) {
        if (state is ListFeedbackLoading || state is ListFeedbackInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ListFeedbackLoaded) {
          return Expanded(
            child: ListView.builder(
                itemCount: state.feedbacks.length,
                itemBuilder: (context, index) {
                  final feedback = state.feedbacks[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    child: Card(
                      child: ListTile(
                        title: Text(
                          feedback.comments,
                          style: Theme.of(context).textTheme.titleMedium!,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rating: ${feedback.rating}',
                            ),
                            Text(
                              'User: ${feedback.user}',
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        } else {
          return const Center(child: Text('An error occurred'));
        }
      },
    );
  }
}
