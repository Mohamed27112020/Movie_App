import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class LoadingLottie extends StatelessWidget {
  const LoadingLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 150.w,
        height: 150.h,
        child: Lottie.asset('assets/loading/load.json'),
      ),
    );
  }
}
