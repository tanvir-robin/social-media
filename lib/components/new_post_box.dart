import 'package:appifylab_task/views/Feed/new_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewPostBox extends StatelessWidget {
  const NewPostBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.shade400,
            width: 0.7,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Icon
              Image.asset(
                'assets/icons/avatar.png',
                height: 60,
              ),

              // Input Field with Hero
              Expanded(
                child: Hero(
                  tag: 'postTextField',
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        alignLabelWithHint: false,
                        label: Text(
                          "Write Something here...",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                      ),
                      onTap: () {
                        Get.to(() => CreatePostScreen());
                      },
                    ),
                  ),
                ),
              ),

              // Post Button
              ElevatedButton(
                onPressed: () {
                  Get.to(() => CreatePostScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004852),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Post",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
