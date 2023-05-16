// ignore_for_file: no_logic_in_create_state, library_private_types_in_public_api, constant_identifier_names, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'avatar_circular_widget.dart';
import 'full_screen_image_widget.dart';
import 'avatar_square_widget.dart';
import 'shadow_text_widget.dart';

class AvatarWidget extends StatefulWidget {
  final String? letters;
  final String? imageUrl;
  final double avatarCircleRadius;
  final double avatarSquareSize;
  final AvatarType avatarType;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderThickness;
  final double borderElevation;
  final VoidCallback? onTap;

  const AvatarWidget({
    Key? key,
    required this.avatarCircleRadius,
    this.avatarSquareSize = 200.0,
    this.letters = 'AV',
    this.imageUrl,
    this.avatarType = AvatarType.CIRCLE,
    this.backgroundColor,
    this.borderColor,
    this.borderThickness = 10.0,
    this.borderElevation = 1.0,
    this.onTap,
  }) : super(key: key);

  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.avatarType == AvatarType.SQUARE
        ? BorderRadius.zero
        : BorderRadius.circular(widget.avatarCircleRadius);

    final imageUrlCircle = widget.imageUrl;
    final imageUrlSquare = imageUrlCircle;

    final child =
        widget.avatarType == AvatarType.CIRCLE && imageUrlCircle != null
            ? ClipRRect(
                borderRadius: borderRadius,
                child: CachedNetworkImage(
                  imageUrl: imageUrlCircle,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )
            : Center(
                child: ShadowTextWidget(
                  text: widget.letters!.toUpperCase().substring(0, 2),
                  style: TextStyle(
                    fontSize: widget.avatarCircleRadius / 2.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );

    return GestureDetector(
      onTap: widget.onTap ??
          () {
            if (widget.imageUrl != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullScreenImageWidget(
                    imageUrl: widget.imageUrl!,
                  ),
                ),
              );
            }
          },
      child: widget.avatarType == AvatarType.CIRCLE
          ? AvatarCircularWidget(
              avatarCircleRadius: widget.avatarCircleRadius,
              imageUrl: imageUrlCircle,
              backgroundColor: widget.backgroundColor ?? Colors.grey[300],
              borderColor: widget.borderColor,
              borderElevation: widget.borderElevation,
              borderThickness: widget.borderThickness,
              letters: widget.letters,
              child: child,
            )
          : AvatarSquareWidget(
              avatarSquareSize: widget.avatarSquareSize,
              imageUrl: imageUrlSquare,
              backgroundColor: widget.backgroundColor ?? Colors.grey[300],
              borderColor: widget.borderColor,
              borderElevation: widget.borderElevation,
              borderThickness: widget.borderThickness,
              letters: widget.letters,
              child: child,
            ),
    );
  }
}

enum AvatarType {
  CIRCLE,
  SQUARE,
}
