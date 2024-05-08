import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';
import 'package:skill_share/presentation/screens/google_sign_in.dart';
import 'package:skill_share/presentation/screens/wrapper.dart';

class GoogleSignInWrapper extends StatelessWidget {
  const GoogleSignInWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return GoogleSignInPage();
        } else {
          context.read<AuthenticationBloc>().add(LogIn());
          return const WrapperPage();
        }
      },
    );
  }
}
