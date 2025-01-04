import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF125c67),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {},
            color: Colors.white,
            iconSize: 30,
            icon: const Icon(HugeIcons.strokeRoundedMenu02),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Python Developer Community',
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
              Text('#General',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFFB7CfD1),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
