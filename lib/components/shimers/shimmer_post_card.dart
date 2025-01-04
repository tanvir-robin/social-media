import 'package:appifylab_task/components/shimers/container_shimmer.dart';
import 'package:appifylab_task/helpers/utils.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class ShimmerPostCard extends StatelessWidget {
  const ShimmerPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const ContainerShimmer(
                width: 50,
                height: 50,
                shape: BoxShape.circle,
              ),
              Utils.getSpacer(width: 5),
              Column(children: [
                const ContainerShimmer(
                  width: 100,
                  height: 15,
                ),
                Utils.getSpacer(height: 5),
                const ContainerShimmer(
                  width: 100,
                  height: 10,
                ),
              ]),
            ],
          ),
          Utils.getSpacer(height: 10),
          ContainerShimmer(
            width: Utils.getCurrentScreenWidth(context) * .9,
            height: 1,
          ),
          Utils.getSpacer(height: 10),
          ContainerShimmer(
            height: 10,
            width: Utils.getCurrentScreenWidth(context) * .9,
          ),
          Utils.getSpacer(height: 4),
          ContainerShimmer(
            height: 10,
            width: Utils.getCurrentScreenWidth(context) * .9,
          ),
          Utils.getSpacer(height: 4),
          ContainerShimmer(
            height: 10,
            width: Utils.getCurrentScreenWidth(context) * .65,
          ),
          Utils.getSpacer(height: 10),
          Shimmer.fromColors(
            baseColor: Colors.grey[500]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: Utils.getCurrentScreenWidth(context) * .9,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: RadialGradient(
                  colors: [
                    Colors.grey,
                    Colors.grey.shade300,
                  ],
                  center: Alignment.center,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Utils.getSpacer(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ContainerShimmer(
                    shape: BoxShape.circle,
                    height: 15,
                    width: 15,
                  ),
                  const ContainerShimmer(
                    shape: BoxShape.circle,
                    height: 15,
                    width: 15,
                  ),
                  Utils.getSpacer(width: 2),
                  const ContainerShimmer(
                    height: 15,
                    width: 30,
                  ),
                ],
              ),
              ContainerShimmer(
                height: 15,
                width: Utils.getCurrentScreenWidth(context) * .2,
              ),
            ],
          ),
          Utils.getSpacer(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  // const ContainerShimmer(
                  //   height: 20,
                  //   width: 20,
                  // ),
                  // Utils.getSpacer(width: 5),
                  ContainerShimmer(
                    height: 20,
                    width: 60,
                  ),
                ],
              ),
              Row(
                children: [
                  const ContainerShimmer(
                    height: 20,
                    width: 20,
                  ),
                  Utils.getSpacer(width: 5),
                  const ContainerShimmer(
                    height: 20,
                    width: 80,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
