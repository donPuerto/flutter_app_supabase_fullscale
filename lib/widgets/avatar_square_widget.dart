import 'package:flutter/material.dart';

class AvatarSquareWidget extends StatelessWidget {
  const AvatarSquareWidget({
    Key? key,
    this.child,
    required this.avatarSquareSize,
    required this.borderElevation,
    this.backgroundColor,
    required this.borderColor,
    required this.borderThickness,
    this.imageUrl,
    this.letters,
  }) : super(key: key);

  final Widget? child;
  final double avatarSquareSize;
  final double borderElevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderThickness;
  final String? imageUrl;
  final String? letters;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(avatarSquareSize * 0.25);

    return Material(
      elevation: borderElevation,
      borderRadius: borderRadius,
      child: Container(
        width: avatarSquareSize,
        height: avatarSquareSize,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
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
          borderRadius: BorderRadius.circular(avatarSquareSize * 0.20),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  width: avatarSquareSize,
                  height: avatarSquareSize,
                  fit: BoxFit.cover,
                )
              : child is Text
                  ? child
                  : Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          letters ?? '',
                          style: TextStyle(
                            fontSize: avatarSquareSize * 0.4,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
