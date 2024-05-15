import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';
import 'package:skill_share/presentation/screens/home.dart';
import 'package:skill_share/presentation/screens/login_loading.dart';

class WrapperPage extends StatelessWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: context.read<AuthenticationBloc>().stream,
      initialData: context.read<AuthenticationBloc>().state,
      builder: (context, snapshot) {
        if (snapshot.data is Authenticated) {
          return const HomeScreen();
        } else if (snapshot.data is AuthenticationError) {
          print((snapshot.data as AuthenticationError).message);
          return const Center(
            child: Text('An error occurred'),
          );
        } else {
          return const LoginLoadingPage();
        }
      },
    );
  }
}
