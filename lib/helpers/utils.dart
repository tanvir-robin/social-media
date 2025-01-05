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

  static String flutterToCssGradient(LinearGradient gradient) {
    final colors = gradient.colors;

    double angle = 0.0;
    if (gradient.transform is GradientRotation) {
      angle = (gradient.transform as GradientRotation).radians;
    }

    int cssAngle = ((angle * 180 / 3.141592653589793) % 360).toInt();

    String cssGradient = 'linear-gradient(${cssAngle}deg, ';

    String colorToRgb(Color color) {
      return 'rgb(${color.red}, ${color.green}, ${color.blue})';
    }

    cssGradient += colors.map((color) => colorToRgb(color)).join(', ');
    cssGradient += ')';

    return cssGradient;
  }

  static LinearGradient cssToFlutterGradient(String cssGradient) {
    final angleMatch =
        RegExp(r'linear-gradient\((\d+)deg').firstMatch(cssGradient);
    final colorMatches =
        RegExp(r'rgb\((\d+), (\d+), (\d+)\)').allMatches(cssGradient);

    double angle = double.parse(angleMatch?.group(1) ?? '0');
    angle = angle * 3.141592653589793 / 180;

    List<Color> colors = [];
    for (final match in colorMatches) {
      int r = int.parse(match.group(1)!);
      int g = int.parse(match.group(2)!);
      int b = int.parse(match.group(3)!);
      colors.add(Color.fromRGBO(r, g, b, 1));
    }

    return LinearGradient(
      begin: const Alignment(-1.0, 0.0),
      end: const Alignment(1.0, 0.0),
      transform: GradientRotation(angle),
      colors: colors,
    );
  }

  static Color getContrastingTextColor(LinearGradient gradient) {
    double totalLuminance = 0.0;
    for (Color color in gradient.colors) {
      totalLuminance += color.computeLuminance();
    }
    double averageLuminance = totalLuminance / gradient.colors.length;

    return averageLuminance < 0.5 ? Colors.white : Colors.black;
  }
}
