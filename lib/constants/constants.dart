class ApiConstants {
  static const String baseUrl =
      "https://9caa-2409-40e3-2c-8b22-f194-3bb8-eaee-632d.ngrok-free.app/";
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
}
