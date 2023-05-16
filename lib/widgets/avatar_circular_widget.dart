import 'package:flutter/material.dart';

class AvatarCircularWidget extends StatelessWidget {
  const AvatarCircularWidget({
    Key? key,
    this.child,
    required this.avatarCircleRadius,
    required this.borderElevation,
    required this.borderColor,
    required this.borderThickness,
    this.backgroundColor,
    this.imageUrl,
    this.letters,
  }) : super(key: key);

  final Widget? child;
  final double avatarCircleRadius;
  final double borderElevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderThickness;
  final String? imageUrl;
  final String? letters;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(avatarCircleRadius);

    return Material(
      elevation: borderElevation,
      borderRadius: borderRadius,
      child: Container(
        width: avatarCircleRadius * 2,
        height: avatarCircleRadius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? Colors.grey[400]!,
            width: borderThickness,
          ),
          color: backgroundColor ?? Colors.grey[400],
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              offset: const Offset(5, 5),
              color: Colors.grey.shade400,
            ),
            const BoxShadow(
              blurRadius: 10,
              offset: Offset(-5, -5),
              color: Colors.white,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: avatarCircleRadius * 2,
                  height: avatarCircleRadius * 2,
                  fit: BoxFit.cover,
                )
              : child is Text
                  ? child
                  : Center(
                      child: Text(
                        letters ?? '',
                        style: TextStyle(
                          fontSize: avatarCircleRadius * 0.8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
