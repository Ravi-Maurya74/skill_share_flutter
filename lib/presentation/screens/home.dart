import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: TextButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogOut());
            },
            child: const Text("LogOut")),
      ),
    );
  }
}
