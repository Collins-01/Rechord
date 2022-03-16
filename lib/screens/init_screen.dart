import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/widgets/app_logo.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppLogo(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // RippleAnimation(
                  //   repeat: true,
                  //   color: AppColors.blue,
                  //   minRadius: 160,
                  //   ripplesCount: 5,
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     height: 160,
                  //     width: 160,
                  //     child: const Icon(
                  //       Icons.mic,
                  //       color: Colors.white,
                  //       size: 32,
                  //     ),
                  //     decoration: const BoxDecoration(
                  //       color: AppColors.blue,
                  //       shape: BoxShape.circle,
                  //     ),
                  //   ),
                  // ),
                  const Spacer(),
                  Container(
                      height: 95,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.lightBlack,
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Positioned(
                            right: 0,
                            top: -10,
                            child: Container(
                              height: 50,
                              width: 50,
                              child: const Icon(
                                Icons.list_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                              decoration: const BoxDecoration(
                                color: AppColors.blue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Recordings',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '24 Items',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
