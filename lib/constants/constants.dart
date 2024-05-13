class ApiConstants {
  static const String baseUrl =
      "https://e7a5-2401-4900-1c83-d4dc-3d97-e29d-ed1f-9aa9.ngrok-free.app/";
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
