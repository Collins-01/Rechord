import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';

class BuildRoundButtons extends StatelessWidget {
  
  final VoidCallback callback;
  final IconData icon;
  const BuildRoundButtons(
      {Key? key, required this.callback, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColorBlured,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
