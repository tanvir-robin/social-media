import 'dart:async';
import 'dart:convert';

import 'package:appifylab_task/Api/endpoints.dart';
import 'package:appifylab_task/constraints/post_colors.dart';
import 'package:appifylab_task/controllers/auth_controller.dart';
import 'package:appifylab_task/helpers/alerts.dart';
import 'package:appifylab_task/models/comment.dart';
import 'package:appifylab_task/models/community_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FeedController extends GetxController {
  static FeedController instance = Get.find<FeedController>();
  Timer? feedUpdateTimer;
  FocusNode commentFocusNode = FocusNode();
  TextEditingController postTextController = TextEditingController();
  List<Post> allCommunityPosts = [];
  List<Comment> comments = [];
  bool isReplying = false;
  bool isLoading = false;
  bool isColorPaletteExpanded = false;
  String replyigTo = "";
  String replyingToID = "";
  LinearGradient? postColor;
  int? postColorIndex;

  @override
  onInit() {
    super.onInit();
    getFeed();
    startFeedUpdateTimer();
    postColor = PostColors.gradientsColor.first;
    postColorIndex = 0;
  }

  startLoading() {
    isLoading = true;
    update();
  }

  stopLoading() {
    isLoading = false;
    update();
  }

  updateScreen() {
    update();
  }

  Future<void> getFeed() async {
    try {
      startLoading();
      final token = AuthController.instance.loginResponse!.token;
      final response = await http.post(
        Uri.parse(ApiEndoints.baseUrl + ApiEndoints.feed),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'community_id': '2914', 'space_id': '5883'}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        allCommunityPosts =
            List<Post>.from(responseData.map((x) => Post.fromJson(x)));
        stopLoading();
        update();
      } else {
        stopLoading();
        Alerts.showError(message: 'Failed to load feed');
      }
    } catch (e) {
      stopLoading();
      Alerts.showError(message: 'Failed to load feed');
    }
  }

  Future<void> getFeedIntheBackgorund() async {
    try {
      final token = AuthController.instance.loginResponse!.token;
      final response = await http.post(
        Uri.parse(ApiEndoints.baseUrl + ApiEndoints.feed),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'community_id': '2914', 'space_id': '5883'}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        allCommunityPosts =
            List<Post>.from(responseData.map((x) => Post.fromJson(x)));
        stopLoading();
        update();
      } else {
        Alerts.showToast(message: 'No network connection');
      }
    } catch (e) {
      Alerts.showToast(message: 'No network connection');
    }
  }

  Future<void> createPost() async {
    if (postTextController.text.isEmpty) {
      Alerts.showError(message: 'Please write something to post');
      return;
    }

    try {
      Alerts.showLoading(message: 'Creating Post...');
      final token = AuthController.instance.loginResponse!.token;
      final response = await http.post(
        Uri.parse(ApiEndoints.baseUrl + ApiEndoints.newPost),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'community_id': '2914',
          'space_id': '5883',
          'feed_txt': postTextController.text,
          'uploadType': 'text',
          'activity_type': 'group',
          'is_background': postColorIndex == 0 ? 0 : 1,
          if (postColorIndex != 0)
            'bg_color': PostColors
                .feedBackGroundGradientColorsToPost[postColorIndex ?? 0],
        }),
      );
      if (response.statusCode == 200) {
        await getFeed();
        update();
        postTextController.clear();
        Alerts.dismiss();
        Get.back();
        Alerts.showToast(message: 'Post created successfully');
      } else {
        Alerts.dismiss();
        Alerts.showError(message: 'Failed to post');
      }
    } catch (e) {
      Alerts.dismiss();
      Alerts.showError(message: 'Failed to post');
    }
  }

  Future<void> addOrRemoveReaction(String feedId, String reaction) async {
    try {
      final token = AuthController.instance.loginResponse!.token;

      final response = await http.post(
        Uri.parse(ApiEndoints.baseUrl + ApiEndoints.addDeleteReaction),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'reaction_type': reaction.toUpperCase(),
          'action': 'deleteOrCreate',
          'feed_id': feedId,
          'reactionSource': 'COMMUNITY',
        }),
      );

      if (response.statusCode == 200) {
        await getFeed();
        update();
      } else {
        Alerts.showError(message: 'Failed to like post');
      }
    } catch (e) {
      Alerts.showError(message: 'Failed to like post');
    }
  }

  void startFeedUpdateTimer() {
    feedUpdateTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      getFeedIntheBackgorund();
    });
  }

  Future<void> createComment(
      String feedId, String userId, String commentText) async {
    if (commentText.isEmpty) {
      Alerts.showError(message: 'Please write something to comment');
      return;
    }

    try {
      Alerts.showLoading(message: 'Posting comment...');
      final token = AuthController.instance.loginResponse!.token;
      final response = await http.post(
        Uri.parse(ApiEndoints.baseUrl + ApiEndoints.createComment),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'feed_id': feedId,
          'feed_user_id': userId,
          'comment_txt': commentText,
          'commentSource': 'COMMUNITY',
          if (isReplying) 'parrent_id': replyingToID
        }),
      );

      if (response.statusCode == 200) {
        await getFeed();
        update();
        Alerts.dismiss();
        Get.back();
        Alerts.showToast(message: 'Comment posted successfully');
      } else {
        Alerts.dismiss();
        Alerts.showError(message: 'Failed to comment');
      }
    } catch (e) {
      print(e);
      Alerts.dismiss();
      Alerts.showError(message: 'Failed to comment');
    }
  }

  Future<void> fetchComments(String feedId) async {
    final String url =
        'https://iap.ezycourse.com/api/app/student/comment/getComment/$feedId';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer ${AuthController.instance.loginResponse!.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        comments = List<Comment>.from(data.map((x) => Comment.fromJson(x)));

        // for (var element in comments) {
        //   final replyUrl =
        //       'https://iap.ezycourse.com/api/app/student/comment/getReply/${element.id}';
        //   final replyResponse = await http.get(
        //     Uri.parse(replyUrl),
        //     headers: {
        //       'Authorization':
        //           'Bearer ${AuthController.instance.loginResponse!.token}',
        //       'Content-Type': 'application/json',
        //     },
        //   );

        //   if (replyResponse.statusCode == 200) {
        //     final replyData = json.decode(replyResponse.body);
        //     element.replieComments =
        //         List<Comment>.from(replyData.map((x) => Comment.fromJson(x)));
        //   } else {
        //     Alerts.showToast(message: 'Failed to load replies');
        //   }
        // }
      } else {
        Alerts.showToast(message: 'Failed to load comments');
      }
    } catch (e) {
      Alerts.showToast(message: 'Failed to load comments');
    }
  }

  Future<void> fetchReplies(Comment comment) async {
    final String url =
        'https://iap.ezycourse.com/api/app/student/comment/getReply/${comment.id}';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer ${AuthController.instance.loginResponse!.token}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        comments
                .firstWhere((element) => element.id == comment.id)
                .replieComments =
            List<Comment>.from(data.map((x) => Comment.fromJson(x)));
        update();
      } else {
        Alerts.showToast(message: 'Failed to load replies');
      }
    } catch (e) {
      Alerts.showToast(message: 'Failed to load replies');
    }
  }

  @override
  void onClose() {
    feedUpdateTimer?.cancel();
    postTextController.dispose();
    super.onClose();
  }
}
