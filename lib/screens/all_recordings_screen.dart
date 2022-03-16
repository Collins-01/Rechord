import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';

class AllRecordingsScreen extends StatefulWidget {
  const AllRecordingsScreen({Key? key}) : super(key: key);

  @override
  State<AllRecordingsScreen> createState() => _AllRecordingsScreenState();
}

class _AllRecordingsScreenState extends State<AllRecordingsScreen> {
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
                itemBuilder: (_, index) => SizedBox(
                  // height: 70,
                  child: ListTile(
                    leading: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (_) => Container(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                      const Text(
                                        'My Recording',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // const Spacer(),
                                  Container(
                                    height: 90,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                        Slider.adaptive(
                                          // inactiveColor: Colors.white,
                                          min: 0,
                                          max: 100,
                                          value: value,

                                          onChanged: (value) {
                                            change(value);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            decoration: const BoxDecoration(
                              color: AppColors.lightBlack,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            height: 147,
                          ),
                        );
                      },
                      icon: const Icon(
                        CupertinoIcons.play,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    title: const Text(
                      "My Recording",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: const Text(
                      "2/01/2001",
                      style: TextStyle(
                        color: Color(0xff484848),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Color(0xff484848),
                        size: 24,
                      ),
                    ),
                  ),
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

   double value = 0;

  change(double val) {
    setState(() {
      value = val;
    });
  }
}
