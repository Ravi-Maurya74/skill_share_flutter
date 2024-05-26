class ApiConstants {
  static const String baseUrl =
      "https://4633-2409-40e3-2d-8349-286f-a8e1-1e81-3ba8.ngrok-free.app/";
}

class UserApiConstants {
  static const String authenticate = "${ApiConstants.baseUrl}user/";
  static const String searchUser = "${ApiConstants.baseUrl}user/search/";
}

class ChatApiConstants {
  static const String listCreateChat = "${ApiConstants.baseUrl}chat/";
}

class CommunityApiConstants {
  static const String listCreateCommunity = "${ApiConstants.baseUrl}community/";
}

class PostApiConstants {
  static const String listCreatePost = "${ApiConstants.baseUrl}post/";
  static const String savePost = "${ApiConstants.baseUrl}post/save/";
  static const String votePost = "${ApiConstants.baseUrl}post/vote/";
  static const String savedPosts = "${ApiConstants.baseUrl}post/saved/";
}

class SkillApiConstants {
  static const String listCreateSkill =
      "${CommunityApiConstants.listCreateCommunity}skills/";
}

class SessionApiConstants {
  static const String listCreateSession = "${ApiConstants.baseUrl}/community/sessions/";
}
