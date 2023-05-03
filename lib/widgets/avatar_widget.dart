// ignore_for_file: constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'full_screen_image_widget.dart';
import 'shadow_text_widget.dart';

class Avatar extends StatefulWidget {
  final String? initials;
  final String? imageUrl;
  final double avatarRadius;
  final AvatarType avatarType;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderThickness;
  final double borderElevation;
  final VoidCallback? onTap;

  const Avatar({
    Key? key,
    required this.avatarRadius,
    this.initials,
    this.imageUrl,
    this.avatarType = AvatarType.CIRCLE,
    this.backgroundColor,
    this.borderColor,
    this.borderThickness = 10.0,
    this.borderElevation = 1.0,
    this.onTap,
  }) : super(key: key);

  @override
  State<Avatar> createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  late List<BoxShadow> borderBoxShadows;

  @override
  void initState() {
    super.initState();
    borderBoxShadows = [
      BoxShadow(
        offset: const Offset(-20, -20),
        blurRadius: 60,
        color: widget.borderColor!,
        inset: true,
      ),
      BoxShadow(
        offset: const Offset(20, 20),
        blurRadius: 60,
        color: widget.borderColor!,
        inset: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
      child: Material(
        elevation: widget.borderElevation,
        shape: widget.avatarType == AvatarType.CIRCLE
            ? const CircleBorder()
            : const RoundedRectangleBorder(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: widget.backgroundColor ?? Colors.grey[400],
        child: Container(
          width: widget.avatarRadius * 2.0,
          height: widget.avatarRadius * 2.0,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.grey[400],
            shape: widget.avatarType == AvatarType.CIRCLE
                ? BoxShape.circle
                : BoxShape.rectangle,
            border: Border.all(
              color: widget.borderColor!,
              width: widget.borderThickness,
            ),
            boxShadow: borderBoxShadows,
          ),
          child: widget.imageUrl != null
              ? Container(
                  decoration: BoxDecoration(
                    boxShadow: borderBoxShadows,
                    borderRadius: BorderRadius.circular(widget.avatarRadius),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.avatarRadius),
                    child: CachedNetworkImage(
                      imageUrl: widget.imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                )
              : Center(
                  child: ShadowTextWidget(
                    text: widget.initials != null && widget.initials!.isNotEmpty
                        ? widget.initials!.toUpperCase().substring(0, 2)
                        : 'AV',
                    style: TextStyle(
                      fontSize: widget.avatarRadius / 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

enum AvatarType {
  CIRCLE,
  RECTANGLE,
}
