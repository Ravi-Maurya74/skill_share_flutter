import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/all_dms/all_dms_bloc.dart';
import 'package:skill_share/presentation/screens/chat_screen.dart';

class DmsTab extends StatelessWidget {
  const DmsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDmsBloc, AllDmsState>(
        bloc: AllDmsBloc(),
        builder: (context, state) {
          if (state is AllDmsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AllDmsLoaded) {
            return ListView.builder(
              itemCount: state.dms.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.dms[index].participants[0].name),
                  subtitle: Text(state.dms[index].participants[0].email),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ChatScreen(chat: state.dms[index])));
                  },
                );
              },
            );
          } else {
            // print((state as AllDmsError).message);
            return const Center(child: Text('An error occurred'));
          }
        });
  }
}
