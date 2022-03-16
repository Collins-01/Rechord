import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';

class AllRecordingsScreen extends StatelessWidget {
  const AllRecordingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.white,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) => Container(
                  height: 70,
                  color: Colors.red,
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.white,
                ),
                itemCount: 10,
              ),
            )
          ],
        ),
      ),
    );
  }
}
