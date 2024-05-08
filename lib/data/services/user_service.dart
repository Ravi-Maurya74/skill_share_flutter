import 'package:skill_share/data/repositories/user_repository.dart';
import 'package:skill_share/data/models/user.dart';

class UserService {
  final UserRepository _userRepository;

  UserService({required UserRepository userRepository})
      : _userRepository = userRepository;

  Future<User> signIn() async {
    return _userRepository.djangoSignIn();
  }

  Future<void> signOut() async {
    await _userRepository.signOut();
  }
}
