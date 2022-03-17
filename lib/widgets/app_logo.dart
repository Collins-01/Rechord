import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text.rich(
        TextSpan(
          text: 'Re',
          style: TextStyle(
            color: AppColors.kGrey,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
          children: <TextSpan>[
            TextSpan(
              text: 'chord',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
