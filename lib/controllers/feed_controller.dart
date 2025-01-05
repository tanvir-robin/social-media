import 'dart:async';
import 'dart:convert';

import 'package:appifylab_task/Api/endpoints.dart';
import 'package:appifylab_task/constraints/post_colors.dart';
import 'package:appifylab_task/controllers/auth_controller.dart';
import 'package:appifylab_task/helpers/alerts.dart';
import 'package:appifylab_task/helpers/utils.dart';
import 'package:appifylab_task/models/comment.dart';
import 'package:appifylab_task/models/community_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FeedController extends GetxController {
  static FeedController instance = Get.find<FeedController>();
  final ScrollController scrollController = ScrollController();
  Timer? feedUpdateTimer;
  FocusNode commentFocusNode = FocusNode();
  TextEditingController postTextController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  List<Post> allCommunityPosts = [];
  List<Comment> comments = [];
  bool isReplying = false;
  bool isLoading = false;
  bool isLoadingMore = false;
  bool isFetchingReply = false;
  bool isColorPaletteExpanded = false;
  String replyigTo = "";
  String replyingToID = "";
  LinearGradient? postColor;
  int? postColorIndex;
  bool isPickedBackground = false;

  @override
  onInit() {
    super.onInit();
    getFeed();
    startFeedUpdateTimer();
    postColor = PostColors.gradientsColor.first;
    postColorIndex = 0;
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.75) {
        if (!isLoadingMore) {
          laodMoreFeed();
        }
      }
    });
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

  Future<void> laodMoreFeed() async {
    try {
      isLoadingMore = true;
      update();
      final token = AuthController.instance.loginResponse!.token;
      final response = await http.post(
        Uri.parse(
            '${ApiEndoints.baseUrl}${ApiEndoints.feed}&more=${allCommunityPosts.last.id}'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'community_id': '2914', 'space_id': '5883'}),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        allCommunityPosts
            .addAll(List<Post>.from(responseData.map((x) => Post.fromJson(x))));
        isLoadingMore = false;

        update();
      } else {
        isLoadingMore = false;
        update();
        Alerts.showError(message: 'Failed to load feed');
      }
    } catch (e) {
      isLoadingMore = false;

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
            'bg_color': Utils.flutterToCssGradient(postColor!),
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
      //doing it locally
      final post = allCommunityPosts
          .firstWhere((element) => element.id.toString() == feedId);
      if (post.like != null) {
        if (post.like!['reaction_type'] == reaction) {
          post.like = null;
          post.likeCount = post.likeCount! - 1;
          if (post.likeType != null) {
            post.likeType!.removeWhere(
                (e) => e.reactionType.toLowerCase() == reaction.toLowerCase());
          }
        } else {
          post.like = {
            'reaction_type': reaction,
            'action': 'deleteOrCreate',
            'feed_id': feedId,
            'reactionSource': 'COMMUNITY',
          };

          if (post.likeType != null) {
            if (!post.likeType!.any((e) =>
                e.reactionType.toLowerCase() == reaction.toLowerCase())) {
              post.likeType!.add(LikeType(
                  feedId: int.parse(feedId), meta: {}, reactionType: reaction));
            }
          } else {
            post.likeType = [
              LikeType(
                  feedId: int.parse(feedId), meta: {}, reactionType: reaction)
            ];
          }
        }
      } else {
        post.like = {
          'reaction_type': reaction,
          'action': 'deleteOrCreate',
          'feed_id': feedId,
          'reactionSource': 'COMMUNITY',
        };
        post.likeCount = post.likeCount! + 1;
        if (post.likeType != null) {
          if (!post.likeType!.any(
              (e) => e.reactionType.toLowerCase() == reaction.toLowerCase())) {
            post.likeType!.add(LikeType(
                feedId: int.parse(feedId), meta: {}, reactionType: reaction));
          }
        } else {
          post.likeType = [
            LikeType(
                feedId: int.parse(feedId), meta: {}, reactionType: reaction)
          ];
        }
      }
      update();

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
        //await getFeed();
        update();
      } else {
        Alerts.showError(message: 'Failed to like post');
      }
    } catch (e) {
      Alerts.showError(message: 'Failed to like post');
    }
  }

  void startFeedUpdateTimer() {
    // feedUpdateTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
    //   getFeedIntheBackgorund();
    // });
  }

  Future<void> createComment(String feedId, String userId) async {
    if (commentController.text.isEmpty) {
      Alerts.showError(message: 'Please write something to comment');
      return;
    }

    try {
      // locally
      if (!isReplying) {
        final post = allCommunityPosts
            .firstWhere((element) => element.id.toString() == feedId);
        post.commentCount = post.commentCount! + 1;
        update();
      }

      // comments.add(Comment(
      //   schoolId: 0,
      //   replyCount: 0,
      //   likeCount: 0,
      //   isAuthorAndAnonymous: false,
      //   replies: [],
      //   totalLikes: [],
      //   reactionTypes: [],
      //   createdAt: DateTime.now(),
      //   updatedAt: DateTime.now(),
      //   commentText: commentText,
      //   feedId: int.parse(feedId),
      //   userId: int.parse(userId),
      //   id: comments.length + 1,
      //   user: User(id: id, fullName: fullName, profilePic: profilePic, userType: userType, meta: meta),
      // ));
      // update();
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
          'comment_txt': commentController.text,
          'commentSource': 'COMMUNITY',
          if (isReplying) 'parrent_id': replyingToID
        }),
      );

      if (response.statusCode == 200) {
        // await getFeed();
        update();
        Alerts.dismiss();
        Get.back();
        Alerts.showToast(message: 'Comment posted successfully');
      } else {
        Alerts.dismiss();
        Alerts.showError(message: 'Failed to comment');
      }
    } catch (e) {
      Alerts.dismiss();
      Alerts.showError(message: 'Failed to comment');
    } finally {
      commentController.clear();
      isReplying = false;
      replyingToID = "";
      replyigTo = "";
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
      isFetchingReply = true;
      update();
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
        isFetchingReply = false;

        update();
      } else {
        isFetchingReply = false;
        update();
        Alerts.showToast(message: 'Failed to load replies');
      }
    } catch (e) {
      isFetchingReply = false;
      update();
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
