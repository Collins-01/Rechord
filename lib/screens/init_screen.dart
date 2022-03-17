import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rechord/screens/all_recordings_screen.dart';
import 'package:rechord/screens/components/build_record_count.dart';
import 'package:rechord/screens/recording_screen.dart';
import 'package:rechord/screens/viewmodels/init_screen_viewmodel.dart';
import 'package:rechord/utils/app_colors.dart';
import 'package:rechord/widgets/app_logo.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

final _initScreenViewModel =
    ChangeNotifierProvider<InitScreenViewModel>((ref) => InitScreenViewModel());

// ignore: must_be_immutable
class InitScreen extends HookConsumerWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(_initScreenViewModel);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(),
              Positioned(
                height: MediaQuery.of(context).size.height / 1.4,
                right: 0,
                left: 0,
                child: Center(
                  child: RippleAnimation(
                    repeat: true,
                    color: AppColors.blue,
                    minRadius: 160,
                    ripplesCount: 5,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const RecordingScreen(),
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 160,
                        width: 160,
                        child: const Icon(
                          Icons.mic,
                          color: Colors.white,
                          size: 32,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 0,
                child: Stack(
                  // fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 95,
                      width: MediaQuery.of(context).size.width,
                      color: AppColors.lightBlack,
                      child: Padding(
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
                            BuildRecordCount()
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 70,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AllRecordingsScreen(),
                            ),
                          );
                        },
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
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
