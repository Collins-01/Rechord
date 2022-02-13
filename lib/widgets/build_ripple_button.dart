import 'package:flutter/material.dart';
import 'package:rechord/utils/app_colors.dart';

class BuildRippleButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback callback;
  const BuildRippleButton(
      {Key? key, required this.callback, required this.isRecording})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          color: AppColors.primaryColorBlured,
          shape: BoxShape.circle,
        ),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            isRecording ? "Stop" : "Rec",
            style: const TextStyle(fontSize: 17, color: Colors.white),
          ),
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
            color: AppColors.kBlue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
