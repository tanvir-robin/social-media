import 'package:appifylab_task/components/home_appbar.dart';
import 'package:appifylab_task/components/logout_dialouge.dart';
import 'package:appifylab_task/components/new_post_box.dart';
import 'package:appifylab_task/components/post_card.dart';
import 'package:appifylab_task/components/shimers/shimmer_post_card.dart';
import 'package:appifylab_task/controllers/feed_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class CommunityFeed extends StatelessWidget {
  const CommunityFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: HomeAppbar(),
      ),
      body: SafeArea(
        child: GetBuilder(
            init: FeedController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const NewPostBox(),
                    if (controller.allCommunityPosts.isEmpty &&
                        controller.isLoading)
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return const ShimmerPostCard();
                          }),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.allCommunityPosts.length,
                        itemBuilder: (context, index) {
                          return PostCard(
                            post: controller.allCommunityPosts[index],
                          );
                        })
                  ],
                ),
              );
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedUserGroup,
              color: Colors.black,
            ),
            activeIcon: HugeIcon(
              icon: Icons.group,
              color: Colors.black,
            ),
            label: "Community",
          ),
          BottomNavigationBarItem(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedLogout01,
              color: Colors.black,
            ),
            label: "Logout",
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            showLogoutAlert(
              context,
            );
          }
        },
      ),
    );
  }
}
