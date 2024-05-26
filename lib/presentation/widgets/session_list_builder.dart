import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/list_session/list_session_bloc.dart';
import 'package:skill_share/data/models/community.dart';
import 'package:skill_share/data/models/list_session.dart';
import 'package:skill_share/presentation/screens/SessionScreen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:math';

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

// ignore: must_be_immutable
class SingleListSessionWidget extends StatelessWidget {
  SingleListSessionWidget({
    super.key,
    required this.session,
  });

  final ListSession session;

  String formatDateTime(DateTime dateTime) {
    var dateFormat = DateFormat('dd/MM/yyyy');
    var timeFormat = DateFormat('h:mm a');
    String date = dateFormat.format(dateTime);
    String time = timeFormat.format(dateTime);
    return '$date, $time';
  }

  var randomNumber = Random().nextInt(5) + 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF272727),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        dense: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SessionScreen(session: session),
              ));
        },
        title: Text(
          session.description,
          style: Theme.of(context).textTheme.titleMedium!,
        ),
        subtitle: Text(formatDateTime(DateTime.parse(session.time))),
        trailing: RatingBar.builder(
          initialRating: randomNumber.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 16.0,
          itemPadding: const EdgeInsets.all(0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {},
        ),
      ),
    );
  }
}
