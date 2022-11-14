import 'package:boom_mobile/screens/profile_screen/sliver_app_bar_delegate.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_flexible_space.dart';
import 'package:boom_mobile/widgets/profile_picture_avatar.dart';
import 'package:flutter/material.dart';

class BoomProfileSliverCustomAppBar extends StatelessWidget {
  final ScrollController scrollController;
  final double profileAvatarDiamater;
  final double profileAvatarShift;
  final String boomsCount;
  final String fansCount;
  final String frensCount;
  final bool isNewUser;
  final String userBio;
  final String profilePictureUrl;
  final String headerImgUrl;
  const BoomProfileSliverCustomAppBar(
      {Key? key,
      required this.scrollController,
      required this.profileAvatarDiamater,
      required this.profileAvatarShift,
      required this.boomsCount,
      required this.fansCount,
      required this.frensCount,
      required this.isNewUser,
      required this.userBio,
      required this.profilePictureUrl,
      required this.headerImgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxAppBarHeight = SizeConfig.screenHeight * 0.32;
    final minAppBarHeight = SizeConfig.screenHeight * 0.1;

    return AnimatedBuilder(
      animation: scrollController,
      builder: ((context, child) {
        return SliverPersistentHeader(
          pinned: true,
          delegate: SliverAppBarDelegate(
            maxHeight: maxAppBarHeight,
            minHeight: minAppBarHeight,
            builder: ((context, shrinkOffset) {
              final double maxHeightBottomEdgeToMinHeightRatio =
                  (shrinkOffset / (maxAppBarHeight - minAppBarHeight))
                      .clamp(0, 1);
              final isAppBarActive = maxHeightBottomEdgeToMinHeightRatio >= 1;
              final double minHeightBottomEdgeToTopHit = isAppBarActive
                  ? (maxAppBarHeight - shrinkOffset) / minAppBarHeight
                  : 0;
              final double profileAvatarBottomPaddingRatio =
                  isAppBarActive ? 1 - minHeightBottomEdgeToTopHit : 0;
              final offset = scrollController.offset;
              final double appbarTitleToTopRatio = (1 -
                      ((maxAppBarHeight +
                              profileAvatarDiamater / 2 +
                              profileAvatarShift -
                              (offset)) /
                          minAppBarHeight))
                  .clamp(0, 1);
              final isAppbarTitleActive = appbarTitleToTopRatio >= 0;

              final double titleOpacity =
                  isAppbarTitleActive ? appbarTitleToTopRatio : 0;
              final children = [
                BoomProfileCustomFlexibleSpace(
                  titleOpacity: titleOpacity,
                  boomsCount: boomsCount,
                  fansCount: fansCount,
                  frensCount: frensCount,
                  isNewUser: isNewUser,
                  userBio: userBio,
                  imageUrl: headerImgUrl,
                ),
                ProfilePictureAvatar(
                  appBarToTopHit: minHeightBottomEdgeToTopHit,
                  bottomToAppbarHitBeforeBlur:
                      maxHeightBottomEdgeToMinHeightRatio,
                  profileAvatarBottomPaddingRatio:
                      profileAvatarBottomPaddingRatio,
                  profilePic: profilePictureUrl,
                  isAppbarActive: isAppBarActive,
                  profileAvatarDiameter: profileAvatarDiamater,
                  profileAvatarShift: profileAvatarShift,
                )
              ];
              return Stack(
                children: children,
              );
            }),
          ),
        );
      }),
    );
  }
}
