import 'package:appifylab_task/controllers/feed_controller.dart';
import 'package:flutter/material.dart';

class CurrentReaction extends StatelessWidget {
  const CurrentReaction(
      {super.key, required this.reaction, required this.feedId});
  final String reaction;
  final String feedId;

  @override
  Widget build(BuildContext context) {
    FeedController feedController = FeedController.instance;
    return InkWell(
      onTap: () {
        feedController.addOrRemoveReaction(feedId, reaction);
      },
      child: Row(
        children: [
          Image.asset('assets/icons/${reaction.toLowerCase()}.png', height: 20),
          const SizedBox(width: 5),
          Text(
            (reaction[0].toUpperCase()) + reaction.substring(1).toLowerCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
