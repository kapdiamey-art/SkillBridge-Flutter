import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final bool hasBorder;

  const GlassCard({
    Key? key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.hasBorder = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: hasBorder ? Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ) : null,
      ),
      child: child,
    );
  }
}
