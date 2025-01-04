import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContainerShimmer extends StatelessWidget {
  const ContainerShimmer(
      {super.key, required this.width, required this.height, this.shape});
  final double width;
  final double height;
  final BoxShape? shape;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[500]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius:
              shape != BoxShape.circle ? BorderRadius.circular(50) : null,
          gradient: RadialGradient(
            colors: [
              Colors.grey,
              Colors.grey.shade300,
            ],
            center: Alignment.center,
          ),
          shape: shape ?? BoxShape.rectangle,
        ),
      ),
    );
  }
}
