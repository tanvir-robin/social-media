import 'package:appifylab_task/components/no_comment.dart';
import 'package:appifylab_task/controllers/feed_controller.dart';
import 'package:appifylab_task/helpers/utils.dart';
import 'package:appifylab_task/models/comment.dart';
import 'package:appifylab_task/models/community_posts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:timeline_tile/timeline_tile.dart';

void showCommentBottomSheet(BuildContext context, Post post) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GetBuilder<FeedController>(builder: (context) {
        return CommentsPage(
          post: post,
        );
      }),
    ),
  );
}

class CommentItem extends StatelessWidget {
  final String userName;
  final String comment;
  final String time;
  final int likes;
  final bool isThreaded;
  final Function()? onReply;
  final Function()? onReplyShow;
  final int replyCount;
  final bool showReplies;
  final String userPic;

  const CommentItem({
    required this.userName,
    required this.userPic,
    required this.replyCount,
    required this.showReplies,
    required this.comment,
    required this.time,
    required this.likes,
    required this.onReply,
    required this.onReplyShow,
    this.isThreaded = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: userPic,
            height: 55,
            width: 55,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 229, 231),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(comment),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          time,
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Like',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: onReply,
                          child: const Text(
                            'Reply',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (replyCount > 0 && !showReplies)
                InkWell(
                  onTap: onReplyShow,
                  child: Text(
                    'View ${replyCount.toString()} replies',
                    style: const TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class CommentsPage extends StatelessWidget {
  CommentsPage({super.key, required this.post});
  final Post post;
  final TextEditingController commentController = TextEditingController();
  final FeedController feedController = FeedController.instance;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: reactionSummary(
                post.likeCount!,
                post.likeType!.map((e) => e.reactionType).toList(),
                post.like != null),
          ),
          Expanded(
            child: feedController.comments.isEmpty
                ? const NoComment()
                : ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: feedController.comments.map((comm) {
                      return _ParentCommentWithChild(
                          comm, comm.replieComments ?? []);
                    }).toList(),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (feedController.isReplying)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Text(
                          'Replying to ${feedController.replyigTo}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Utils.getSpacer(width: 8.0),
                        GestureDetector(
                          onTap: () {
                            feedController.isReplying = false;
                            feedController.replyigTo = '';
                            feedController.replyingToID = '';
                            feedController.updateScreen();
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(24.0),
                  child: TextField(
                    focusNode: feedController.commentFocusNode,
                    controller: commentController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 34,
                      ),
                      suffixIcon: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(24.0),
                              bottomRight: Radius.circular(24.0),
                            ),
                            color: Color(0xFF004852)),
                        width: 65,
                        child: IconButton(
                          onPressed: () {
                            feedController.createComment(post.id.toString(),
                                post.userId.toString(), commentController.text);
                          },
                          icon: Image.asset(
                            'assets/icons/sent.png',
                            width: 24,
                          ),
                        ),
                      ),
                      hintText: 'Write a Comment',
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Utils.getSpacer(height: 16.0),
        ],
      ),
    );
  }
}

class _ParentCommentWithChild extends StatelessWidget {
  const _ParentCommentWithChild(
    this.comment,
    this.replies,
  );
  final Comment comment;
  final List<Comment> replies;
  // final FocusNode commentBoxFocusNode;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.01,
        isFirst: true,
        hasIndicator: false,
        afterLineStyle: LineStyle(
            color: replies.isEmpty ? Colors.transparent : Colors.grey,
            thickness: 1),
        endChild: CommentItem(
          userPic: comment.user.profilePic,
          showReplies: comment.showReplies,
          onReplyShow: () async {
            comment.showReplies = true;
            await FeedController.instance.fetchReplies(comment);
            FeedController.instance.updateScreen();
          },
          replyCount: comment.replyCount,
          onReply: () {
            FeedController.instance.isReplying = true;
            FeedController.instance.replyigTo = comment.user.fullName;
            FeedController.instance.replyingToID = comment.id.toString();
            FeedController.instance.updateScreen();
            FocusScope.of(context)
                .requestFocus(FeedController.instance.commentFocusNode);
          },
          userName: comment.user.fullName,
          comment: comment.commentText,
          time: Utils.timeAgoDate(comment.createdAt),
          likes: 1,
          isThreaded: false,
        ),
      ),
      if ((replies).isNotEmpty)
        ...replies.asMap().entries.map((entry) {
          int idx = entry.key;
          Comment childComment = entry.value;
          return TimelineTile(
            isLast: idx == replies.length - 1,
            alignment: TimelineAlign.manual,
            lineXY: 0.01,
            beforeLineStyle: const LineStyle(
              color: Colors.grey,
              thickness: 1,
            ),
            hasIndicator: false,
            endChild: Row(children: [
              Expanded(
                flex: 1,
                child: CustomPaint(
                  size: Size(
                      MediaQuery.of(context).size.width * 0.1,
                      (MediaQuery.of(context).size.width * 0.01 * .0625)
                          .toDouble()),
                  painter: RPSCustomPainter(),
                ),
              ),
              Flexible(
                flex: 9,
                child: CommentItem(
                  userPic: comment.user.profilePic,
                  showReplies: comment.showReplies,
                  onReplyShow: () async {
                    comment.showReplies = true;
                    await FeedController.instance.fetchReplies(comment);
                  },
                  replyCount: 0,
                  onReply: () {
                    FeedController.instance.isReplying = true;
                    FeedController.instance.replyigTo = comment.user.fullName;
                    FeedController.instance.replyingToID =
                        comment.id.toString();
                    FeedController.instance.updateScreen();
                    FocusScope.of(context)
                        .requestFocus(FeedController.instance.commentFocusNode);
                  },
                  userName: childComment.user.fullName,
                  comment: childComment.commentText,
                  time: Utils.timeAgoDate(comment.createdAt),
                  likes: 1,
                  isThreaded: true,
                ),
              ),
            ]),
          );
        })
    ]);
  }
}

Widget reactionSummary(
    int totalCount, List<String> reactions, bool isLikedByMe) {
  return Row(
    children: [
      for (var i = 0; i < reactions.length; i++)
        Image.asset(
          'assets/icons/${reactions.elementAt(i).toLowerCase()}.png',
          height: 20,
        ),
      Utils.getSpacer(width: 5.0),
      Text(totalCount == 1 && isLikedByMe
          ? "You"
          : isLikedByMe
              ? "You and ${totalCount - 1} other"
              : totalCount == 0
                  ? "Be the first to like"
                  : totalCount.toString()),
    ],
  );
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 2);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
