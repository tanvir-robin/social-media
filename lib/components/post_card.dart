import 'package:appifylab_task/components/comment_bottom_sheet.dart';
import 'package:appifylab_task/components/current_reaction_maker.dart';
import 'package:appifylab_task/components/icon_text_button.dart';

import 'package:appifylab_task/constraints/post_colors.dart';
import 'package:appifylab_task/controllers/feed_controller.dart';
import 'package:appifylab_task/helpers/alerts.dart';
import 'package:appifylab_task/helpers/utils.dart';
import 'package:appifylab_task/models/community_posts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:hugeicons/hugeicons.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    FeedController feedController = FeedController.instance;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: post.pic!,
                  height: 34,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.name ?? "Unknown User",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Utils.timeAgo(post.publishDate!),
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
            ],
          ),
          const Divider(
            thickness: .6,
          ),
          Container(
            width: Utils.getCurrentScreenWidth(context),
            alignment:
                post.bgColor != null ? Alignment.center : Alignment.centerLeft,
            padding: const EdgeInsets.all(10),
            constraints: post.bgColor != null
                ? const BoxConstraints(minHeight: 150)
                : null,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: post.bgColor != null
                  ? Utils.cssToFlutterGradient(post.bgColor!)
                  : null,
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final text = post.feedTxt ?? "";
                    final textSpan = TextSpan(
                      text: text,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    );
                    final textPainter = TextPainter(
                      text: textSpan,
                      maxLines: 3,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);

                    final lineCount = textPainter.computeLineMetrics().length;

                    double fontSize;
                    if (lineCount == 1) {
                      fontSize = 22;
                    } else if (lineCount == 2) {
                      fontSize = 19;
                    } else {
                      fontSize = 14;
                    }

                    return Text(
                      text,
                      style: TextStyle(
                        color: post.bgColor == null
                            ? Colors.black
                            : Utils.getContrastingTextColor(
                                Utils.cssToFlutterGradient(post.bgColor!)),
                        fontSize: fontSize,
                        fontWeight: post.bgColor != null
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                if (post.files != null && post.files!.isNotEmpty)
                  Column(
                    children: post.files!.map((file) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: file.fileLoc,
                            fit: BoxFit.cover,
                            width: Utils.getCurrentScreenWidth(context),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 30,
                width: 200,
                child: reactionSummary(
                    post.likeCount!,
                    post.likeType!.map((e) => e.reactionType).toList(),
                    post.like != null),
              ),
              if (post.commentCount != 0)
                InkWell(
                  onTap: () async {
                    Alerts.showLoading(message: 'Fetching Comments...');
                    await feedController.fetchComments(post.id.toString());
                    Alerts.dismiss();
                    if (context.mounted) {
                      showCommentBottomSheet(context, post);
                    }
                  },
                  child: Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedComment02,
                        color: Colors.black,
                        size: 17,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${post.commentCount} ${post.commentCount! < 2 ? "Comment" : "Comments"}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Utils.getSpacer(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReactionButton<String>(
                itemSize: const Size(45.0, 50.0),
                reactions: buildReactions(),
                onReactionChanged: (reaction) {
                  feedController.addOrRemoveReaction(
                      post.id.toString(), reaction!.value!);
                },
                child: post.like == null
                    ? IconTextButton(
                        icon: Icons.thumb_up_alt_outlined,
                        text: 'Like',
                        onTap: () {
                          feedController.addOrRemoveReaction(
                              post.id.toString(), "Like");
                        },
                      )
                    : CurrentReaction(
                        feedId: post.id.toString(),
                        reaction: post.like!['reaction_type'],
                      ),
              ),
              IconTextButton(
                icon: HugeIcons.strokeRoundedComment01,
                text: 'Comment',
                onTap: () async {
                  Alerts.showLoading(message: 'Fetching Comments...');
                  await feedController.fetchComments(post.id.toString());
                  Alerts.dismiss();
                  if (context.mounted) {
                    showCommentBottomSheet(context, post);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget reactionSummary(
      int totalCount, List<String> reactions, bool isLikedByMe) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        for (var i = 0; i < reactions.length; i++)
          Positioned(
            left: i * 15.0,
            child: Image.asset(
              'assets/icons/${reactions.elementAt(i).toLowerCase()}.png',
              height: 20,
            ),
          ),
        Positioned(
            left: (15 * reactions.length) + 10,
            child: Text(totalCount == 1 && isLikedByMe
                ? "You"
                : isLikedByMe
                    ? "You and ${totalCount - 1} other"
                    : totalCount == 0
                        ? "Be the first to like"
                        : totalCount.toString())),
      ],
    );
  }
}

List<Reaction<String>> buildReactions() {
  return [
    Reaction<String>(
      value: "Like",
      icon: _buildReactionIcon("assets/icons/like.png", "Like"),
    ),
    Reaction<String>(
      value: "Love",
      icon: _buildReactionIcon("assets/icons/love.png", "Love"),
    ),
    Reaction<String>(
      value: "Care",
      icon: _buildReactionIcon("assets/icons/care.png", "Care"),
    ),
    Reaction<String>(
      value: "Haha",
      icon: _buildReactionIcon("assets/icons/haha.png", "Haha"),
    ),
    Reaction<String>(
      value: "Wow",
      icon: _buildReactionIcon("assets/icons/wow.png", "Wow"),
    ),
    Reaction<String>(
      value: "Sad",
      icon: _buildReactionIcon("assets/icons/sad.png", "Sad"),
    ),
    Reaction<String>(
      value: "Angry",
      icon: _buildReactionIcon("assets/icons/angry.png", "Angry"),
    ),
  ];
}

Widget _buildReactionIcon(String imagePath, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    child: Image.asset(imagePath, width: 30, height: 30),
  );
}
