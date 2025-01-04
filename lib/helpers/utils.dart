import 'package:flutter/material.dart';

class Utils {
  static double getCurrentScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getCurrentScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Widget getSpacer({double height = 0.0, double width = 0.0}) {
    return SizedBox(height: height, width: width);
  }

  static String timeAgo(String isoDateString) {
    DateTime parsedDate = DateTime.parse(isoDateString);

    DateTime now = DateTime.now();

    Duration difference = now.difference(parsedDate);

    if (difference.inMinutes < 1) {
      return 'Just Now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} Minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} Hours ago';
    } else {
      return '${difference.inDays} Days ago';
    }
  }

  static String timeAgoDate(DateTime parsedDate) {
    DateTime now = DateTime.now();

    Duration difference = now.difference(parsedDate);

    if (difference.inMinutes < 1) {
      return 'Just Now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} Minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} Hours ago';
    } else {
      return '${difference.inDays} Days ago';
    }
  }
}
