import 'package:appifylab_task/constraints/post_colors.dart';
import 'package:appifylab_task/controllers/feed_controller.dart';
import 'package:appifylab_task/helpers/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: GetBuilder<FeedController>(builder: (feedController) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'Close',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 17,
                              color: Colors.grey.shade800),
                        )),
                    const Text(
                      'Create Post',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    TextButton(
                        onPressed: () => feedController.createPost(),
                        child: const Text(
                          'Create',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Color(0xFF6662FF)),
                        )),
                  ],
                ),
                Utils.getSpacer(height: 10.0),
                Hero(
                  tag: 'postTextField',
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: feedController.postColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: feedController.postTextController,
                      style: TextStyle(
                          color: Utils.getContrastingTextColor(
                              feedController.postColor!)),
                      maxLines: 5,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: .7),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF6662FF), width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        fillColor: Colors.transparent,
                        hintText: "What's on your mind?",
                        hintStyle: TextStyle(
                            color: Utils.getContrastingTextColor(
                                feedController.postColor!),
                            fontWeight: FontWeight.w200),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          feedController.isColorPaletteExpanded =
                              !feedController.isColorPaletteExpanded;
                          feedController.updateScreen();
                        },
                        child: feedController.isColorPaletteExpanded
                            ? Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Icon(
                                  CupertinoIcons.back,
                                  color: Colors.black,
                                ),
                              )
                            : Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.red,
                                      Colors.yellow,
                                      Colors.green,
                                      Colors.blue,
                                      Colors.purple,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Aa',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(width: 8.0),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width:
                            feedController.isColorPaletteExpanded ? 300.0 : 0.0,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: feedController.isColorPaletteExpanded
                                ? PostColors.gradientsColor.map((color) {
                                    return InkWell(
                                      onTap: () {
                                        feedController.postColor = color;
                                        feedController.postColorIndex =
                                            PostColors.gradientsColor
                                                .indexOf(color);
                                        if (feedController.postColorIndex !=
                                            0) {
                                          feedController.isPickedBackground =
                                              true;
                                        }

                                        feedController.updateScreen();
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 5.0),
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          gradient: color,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: feedController.postColor ==
                                                    color
                                                ? Colors.black
                                                : Colors.transparent,
                                            width: 2.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList()
                                : [],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
