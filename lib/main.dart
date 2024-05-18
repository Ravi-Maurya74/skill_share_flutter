import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skill_share/blocs/authentication/authentication_bloc.dart';
import 'package:skill_share/data/repositories/user_repository.dart';
import 'package:skill_share/data/services/user_service.dart';
import 'package:skill_share/presentation/screens/google_sign_in_wrapper.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
          userService: UserService(userRepository: UserRepository())),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0f0f0f),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF0f0f0f),
            scrolledUnderElevation: 0,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Color.fromARGB(255, 224, 215, 214),
            unselectedItemColor: Color.fromARGB(255, 141, 141, 141),
            backgroundColor: Color(0xFF0f0f0f),
            elevation: 10,
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFFfb542b),
          ),
        ),
        // colorScheme: ThemeData.dark().colorScheme.copyWith(
        //       primary: Colors.deepPurple,
        //       secondary: Colors.deepPurpleAccent,
        //     ),
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: const GoogleSignInWrapper(),
      ),
    );
  }
}
