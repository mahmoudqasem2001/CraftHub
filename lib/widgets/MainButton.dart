import 'package:flutter/material.dart';

import '../core/utils/router/AppColors.dart';

class MainButton extends StatelessWidget {
  final double height;
  final Widget? child;
  final String? title;
  final Color bgColor;
  final Color frColor;
  final VoidCallback? onPressed;

  const MainButton({
    super.key,
    this.height = 50,
    this.title,
    this.child,
    this.bgColor = AppColors.primary,
    this.frColor = AppColors.white,
    this.onPressed,
  }) : assert(title != null || child != null);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: frColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: child ?? Text(title!),
      ),
    );
  }
}
