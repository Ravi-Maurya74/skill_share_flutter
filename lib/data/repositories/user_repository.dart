import 'package:firebase_auth/firebase_auth.dart';
import 'package:skill_share/data/models/user.dart' as MyUser;
import 'package:dio/dio.dart';

import 'package:skill_share/constants/constants.dart';

class UserRepository {
  Future<void> googleSignIn() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    try {
      await FirebaseAuth.instance.signInWithProvider(googleProvider);
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<MyUser.User> djangoSignIn() async {
    String? idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    if (idToken == null) {
      throw Exception('Failed to get idToken');
    }
    // Send idToken to Django server using dio
    Response response = await Dio().post(
      UserApiConstants.authenticate,
      options: Options(
        headers: {
          'Authorization': 'Token $idToken',
        },
      ),
    );
    MyUser.User user = MyUser.User.fromMap(response.data);
    return user;
  }
}
