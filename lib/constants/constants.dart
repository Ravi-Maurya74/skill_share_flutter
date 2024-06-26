class ApiConstants {
  static const String baseUrl =
      "http://15.207.115.200:8000/";
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
  static const String member = "${ApiConstants.baseUrl}community/members/";
}

class PostApiConstants {
  static const String listCreatePost = "${ApiConstants.baseUrl}post/";
  static const String savePost = "${ApiConstants.baseUrl}post/save/";
  static const String votePost = "${ApiConstants.baseUrl}post/vote/";
  static const String savedPosts = "${ApiConstants.baseUrl}post/saved/";
  static const String userPosts = "${ApiConstants.baseUrl}post/user/";
  static const String listCreateComments =
      "${ApiConstants.baseUrl}post/comments/";
}

class SkillApiConstants {
  static const String listCreateSkill =
      "${CommunityApiConstants.listCreateCommunity}skills/";
}

class SessionApiConstants {
  static const String listCreateSession =
      "${ApiConstants.baseUrl}community/sessions/";
}

class FeedbackApiConstants {
  static const String listCreateFeedback =
      "${ApiConstants.baseUrl}community/feedback/";
}
