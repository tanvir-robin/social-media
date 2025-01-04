class ApiEndoints {
  static const String baseUrl = 'https://iap.ezycourse.com/api/app';
  static const String login = '/student/auth/login';
  static const String logout = '/student/auth/logout';
  static const String feed = '/teacher/community/getFeed?status=feed&';
  static const String newPost = '/teacher/community/createFeedWithUpload';
  static const String addDeleteReaction = '/teacher/community/createLike';
  static const String createComment = '/student/comment/createComment';
}
