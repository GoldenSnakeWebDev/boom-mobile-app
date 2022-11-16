import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

class ProfilePictureAvatar extends StatelessWidget {
  final double appBarToTopHit;
  final double bottomToAppbarHitBeforeBlur;
  final double profileAvatarBottomPaddingRatio;
  final String profilePic;
  final bool isAppbarActive;
  final double profileAvatarDiameter;
  final double profileAvatarShift;
  const ProfilePictureAvatar(
      {Key? key,
      required this.appBarToTopHit,
      required this.bottomToAppbarHitBeforeBlur,
      required this.profileAvatarBottomPaddingRatio,
      required this.profilePic,
      required this.isAppbarActive,
      required this.profileAvatarDiameter,
      required this.profileAvatarShift})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileAvatarRadius = profileAvatarDiameter / 2;
    final bottomPadding = profileAvatarRadius + profileAvatarShift;
    final scaleRatio = bottomPadding / profileAvatarDiameter;
    final scale = lerpDouble(1, scaleRatio, bottomToAppbarHitBeforeBlur)!;
    final decreasingPadding =
        profileAvatarBottomPaddingRatio * (profileAvatarDiameter * 1.2);
    log("Profile pic $profilePic");
    return Positioned(
      bottom: -bottomPadding -
          bottomToAppbarHitBeforeBlur * bottomPadding * scale +
          profileAvatarShift * (1 + scale) * bottomToAppbarHitBeforeBlur +
          decreasingPadding,
      left: 5 * (1 - bottomPadding),
      child: Transform.scale(
        origin: const Offset(0.5, 0.5),
        scale: scale,
        child: Container(
          foregroundDecoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: profileAvatarRadius,
            backgroundImage: NetworkImage(profilePic),
          ),
        ),
      ),
    );
  }
}
