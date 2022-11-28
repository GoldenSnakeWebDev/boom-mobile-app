import 'dart:developer';

import 'package:boom_mobile/screens/home_screen/controllers/single_boom_controller.dart';
import 'package:boom_mobile/screens/home_screen/models/single_boom_model.dart';
import 'package:boom_mobile/screens/home_screen/services/single_boom_service.dart';
import 'package:boom_mobile/screens/other_user_profile/other_user_profile.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/single_boom_shimmer.dart';
import 'package:boom_mobile/widgets/single_comment_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';

class SingleBoomPage extends StatefulWidget {
  const SingleBoomPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleBoomPage> createState() => _SingleBoomPageState();
}

class _SingleBoomPageState extends State<SingleBoomPage> {
  void _onShare(BuildContext context, String imgURL) async {
    final box = context.findRenderObject() as RenderBox;

    await Share.share(
        "Hey there, check out this NFT $imgURL. To view this NFT on Boom, download the app from https://play.google.com/store/apps/details?id=com.boom.boom_mobile",
        subject: "NFT",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  final box = GetStorage();
  final boomService = SingleBoomService();

  final String boomId = Get.arguments[0];
  final String boomTitle = Get.arguments[1];
  final boomController = Get.put(
    SingleBoomController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContBgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          boomTitle,
          style: TextStyle(
            color: Colors.black,
            fontSize: getProportionateScreenHeight(18),
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        backgroundColor: kContBgColor,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: boomService.getSingleBoom(),
          builder: (context, snapshot) {
            SingleBoom? boom = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              //TODO: Add loading Shimmer
              return const SingleBoomShimmer();
            } else if (snapshot.connectionState == ConnectionState.active ||
                snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Could not fecch boom"),
                );
              } else if (snapshot.hasData) {
                boomController.fetchReactionStatus(boom!);
                return RefreshIndicator(
                  onRefresh: () async {
                    boomController.refreshPage();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * .89,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.4,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: snapshot.data!.boom.boomType == "text"
                                      ? Text(boom.boom.imageUrl)
                                      : CachedNetworkImage(
                                          // height: getProportionateScreenHeight(200),
                                          width: SizeConfig.screenWidth,
                                          imageUrl: boom.boom.imageUrl,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            height:
                                                getProportionateScreenHeight(
                                                    200),
                                            width: SizeConfig.screenWidth,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.grey,
                                            ),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(15),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () =>
                                                const OtherUserProfileScreen(),
                                            arguments: boom.boom.user.id,
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              child: CachedNetworkImage(
                                                height:
                                                    getProportionateScreenHeight(
                                                        45),
                                                width:
                                                    getProportionateScreenHeight(
                                                        45),
                                                imageUrl: boom.boom.user.photo
                                                        .isNotEmpty
                                                    ? boom.boom.user.photo
                                                    : "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  getProportionateScreenHeight(
                                                      5),
                                            ),
                                            Text(
                                              "!${boom.boom.user.username}",
                                              style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        11),
                                                fontWeight: FontWeight.w800,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(8),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Visibility(
                                            visible:
                                                boom.boom.location.isNotEmpty,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  MdiIcons.mapMarker,
                                                  size: 18,
                                                ),
                                                Text(
                                                  boom.boom.location,
                                                  style: TextStyle(
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              15),
                                                      fontWeight:
                                                          FontWeight.w800),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(5),
                                          ),
                                          SizedBox(
                                            height:
                                                getProportionateScreenHeight(
                                                    10),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _onShare(
                                                  context, boom.boom.imageUrl);
                                            },
                                            child: const Icon(
                                              MdiIcons.shareVariant,
                                              size: 18,
                                              color: Colors.black,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          box.read("userId") ==
                                                  boom.boom.user.id
                                              ? showMenu(
                                                  context: context,
                                                  position:
                                                      RelativeRect.fromLTRB(
                                                          SizeConfig
                                                                  .screenWidth *
                                                              0.6,
                                                          SizeConfig
                                                                  .screenHeight *
                                                              0.45,
                                                          SizeConfig
                                                                  .screenWidth *
                                                              0.35,
                                                          60),
                                                  items: [
                                                    PopupMenuItem(
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kBlueColor
                                                              .withOpacity(0.8),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  16.0,
                                                                  4.0,
                                                                  16.0,
                                                                  4.0),
                                                          child: Text(
                                                            "More",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      14),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () {
                                                        Get.snackbar(
                                                            "Coming Soon",
                                                            "Hang in there we are working on it",
                                                            backgroundColor:
                                                                kPrimaryColor);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kBlueColor
                                                              .withOpacity(0.8),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  16.0,
                                                                  4.0,
                                                                  16.0,
                                                                  4.0),
                                                          child: Text(
                                                            "Export",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      14),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : showMenu(
                                                  context: context,
                                                  position:
                                                      RelativeRect.fromLTRB(
                                                    SizeConfig.screenWidth *
                                                        0.6,
                                                    SizeConfig.screenHeight *
                                                        0.45,
                                                    SizeConfig.screenWidth *
                                                        0.35,
                                                    60,
                                                  ),
                                                  constraints: BoxConstraints(
                                                      maxWidth: SizeConfig
                                                              .screenWidth *
                                                          0.35),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  items: [
                                                    PopupMenuItem(
                                                      onTap: () async {
                                                        //Function to synthetically Mint the NFT
                                                        await boomController
                                                            .syntheticallyMintBoom(
                                                                boom.boom.id);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kBlueColor
                                                              .withOpacity(0.8),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  16.0,
                                                                  4.0,
                                                                  16.0,
                                                                  4.0),
                                                          child: Text(
                                                            "Syn. NFT",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      14),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      onTap: () async {
                                                        Get.snackbar(
                                                            "Hang in there",
                                                            "We are working on this feature",
                                                            backgroundColor:
                                                                kPrimaryColor);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: kBlueColor
                                                              .withOpacity(0.8),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  16.0,
                                                                  4.0,
                                                                  16.0,
                                                                  4.0),
                                                          child: Text(
                                                            "Mint NFT",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  getProportionateScreenHeight(
                                                                      14),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 4, 10, 4),
                                            child: Text(
                                              "Obtain",
                                              style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        12),
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(7),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            boom.boom.fixedPrice,
                                            style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      18),
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            "(\$${boom.boom.price})",
                                            style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        11)),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: getProportionateScreenWidth(5),
                                      ),
                                      CachedNetworkImage(
                                        height:
                                            getProportionateScreenHeight(20),
                                        imageUrl: boom.boom.network.imageUrl,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showMenu(
                                            context: context,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            position: RelativeRect.fromLTRB(
                                              SizeConfig.screenWidth,
                                              SizeConfig.screenHeight * 0.45,
                                              30,
                                              60,
                                            ),
                                            items: [
                                              PopupMenuItem(
                                                onTap: () {},
                                                child: Text(
                                                  "View Contract",
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            13),
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                              PopupMenuItem(
                                                onTap: () {},
                                                child: Text(
                                                  "Report Boom",
                                                  style: TextStyle(
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            13),
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        icon: const Icon(
                                          MdiIcons.dotsHorizontal,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),
                              Text(
                                boom.boom.description,
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w900),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(5),
                              ),
                              Text(
                                boom.boom.tags[0],
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(11),
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(10),
                              ),

                              //Ractions Section
                              //TODO: Change this to a widget
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      LikeButton(
                                        animationDuration:
                                            const Duration(milliseconds: 600),
                                        size: getProportionateScreenHeight(28),
                                        bubblesColor: const BubblesColor(
                                            dotPrimaryColor: kPrimaryColor,
                                            dotSecondaryColor: kSecondaryColor),
                                        isLiked: boomController.isLiked,
                                        onTap: (isLiked) async {
                                          log(isLiked.toString());
                                          boomController.reactToBoom(
                                              "likes", boomId);
                                          return null;
                                        },
                                        likeBuilder: ((isLiked) {
                                          return CachedNetworkImage(
                                            height:
                                                getProportionateScreenHeight(
                                                    26),
                                            color: isLiked
                                                ? kPrimaryColor
                                                : Colors.black,
                                            imageUrl:
                                                "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/applaud.png",
                                          );
                                        }),
                                      ),
                                      Text(
                                        "${boom.boom.reactions.likes.length}",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LikeButton(
                                        animationDuration:
                                            const Duration(milliseconds: 600),
                                        size: getProportionateScreenHeight(22),
                                        bubblesColor: const BubblesColor(
                                            dotPrimaryColor: kPrimaryColor,
                                            dotSecondaryColor: kSecondaryColor),
                                        isLiked: boomController.isLoves,
                                        onTap: (isLoves) async {
                                          boomController.reactToBoom(
                                              "loves", boomId);
                                          return null;
                                        },
                                        likeBuilder: ((isLoves) {
                                          return SvgPicture.asset(
                                            height:
                                                getProportionateScreenHeight(
                                                    15),
                                            "assets/icons/love.svg",
                                            color: isLoves
                                                ? Colors.red
                                                : Colors.grey,
                                          );
                                        }),
                                      ),
                                      Text(
                                        "${boom.boom.reactions.loves.length}",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      LikeButton(
                                        animationDuration:
                                            const Duration(milliseconds: 600),
                                        size: getProportionateScreenHeight(26),
                                        bubblesColor: const BubblesColor(
                                            dotPrimaryColor: kPrimaryColor,
                                            dotSecondaryColor: kSecondaryColor),
                                        isLiked: boomController.isSmiles,
                                        onTap: (isSmiles) async {
                                          boomController.reactToBoom(
                                              "smiles", boomId);
                                          return null;
                                        },
                                        likeBuilder: ((isSmiles) {
                                          return CachedNetworkImage(
                                            height:
                                                getProportionateScreenHeight(
                                                    22),
                                            imageUrl:
                                                "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/ipfs/bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu/smile.png",
                                          );
                                        }),
                                      ),
                                      Text(
                                        "${boom.boom.reactions.smiles.length}",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LikeButton(
                                          animationDuration:
                                              const Duration(milliseconds: 600),
                                          size:
                                              getProportionateScreenHeight(20),
                                          isLiked: boomController.isRebooms,
                                          onTap: (isRebooms) async {
                                            boomController.reactToBoom(
                                                "rebooms", boomId);
                                            return null;
                                          },
                                          bubblesColor: const BubblesColor(
                                              dotPrimaryColor: kPrimaryColor,
                                              dotSecondaryColor:
                                                  kSecondaryColor),
                                          likeBuilder: (isRebooms) {
                                            return SvgPicture.asset(
                                              height:
                                                  getProportionateScreenHeight(
                                                      18),
                                              "assets/icons/reboom.svg",
                                            );
                                          }),
                                      Text(
                                        "${boom.boom.reactions.rebooms.length}",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      LikeButton(
                                        animationDuration:
                                            const Duration(milliseconds: 600),
                                        size: getProportionateScreenHeight(20),
                                        onTap: (_) async {
                                          Get.snackbar(
                                            "Hang in there.",
                                            "Shipping soon..",
                                            backgroundColor: kPrimaryColor,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.black,
                                            overlayBlur: 5.0,
                                            margin: EdgeInsets.only(
                                              top: SizeConfig.screenHeight *
                                                  0.05,
                                              left:
                                                  SizeConfig.screenWidth * 0.05,
                                              right:
                                                  SizeConfig.screenWidth * 0.05,
                                            ),
                                          );
                                          return null;
                                        },
                                        bubblesColor: const BubblesColor(
                                            dotPrimaryColor: kPrimaryColor,
                                            dotSecondaryColor: kSecondaryColor),
                                        likeBuilder: ((isLiked) {
                                          return Icon(
                                            MdiIcons.alert,
                                            color: isLiked
                                                ? kYellowTextColor
                                                : Colors.grey,
                                          );
                                        }),
                                      ),
                                      Text(
                                        boom.boom.reactions.reports.length
                                            .toString(),
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LikeButton(
                                        animationDuration:
                                            const Duration(milliseconds: 600),
                                        size: getProportionateScreenHeight(20),
                                        onTap: (_) async {
                                          Get.snackbar(
                                            "Hang in there.",
                                            "Shipping soon..",
                                            backgroundColor: kPrimaryColor,
                                            snackPosition: SnackPosition.TOP,
                                            colorText: Colors.black,
                                            overlayBlur: 5.0,
                                            margin: EdgeInsets.only(
                                              top: SizeConfig.screenHeight *
                                                  0.05,
                                              left:
                                                  SizeConfig.screenWidth * 0.05,
                                              right:
                                                  SizeConfig.screenWidth * 0.05,
                                            ),
                                          );
                                          return null;
                                        },
                                        bubblesColor: const BubblesColor(
                                            dotPrimaryColor: kPrimaryColor,
                                            dotSecondaryColor: kSecondaryColor),
                                        likeBuilder: ((isLiked) {
                                          return const Icon(
                                            MdiIcons.chatOutline,
                                            size: 22,
                                          );
                                        }),
                                      ),
                                      Text(
                                        "${boom.boom.comments.length}",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(15),
                              ),

                              //Add Comment Field

                              //View Comments Section

                              Expanded(
                                flex: 3,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: boom.boom.comments.length,
                                  // physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return SingleComment(
                                      comment:
                                          boom.boom.comments[index].message,
                                      userName:
                                          " ${boom.boom.comments[index].user.username}",
                                      createdAt: boom
                                          .boom.comments[index].createdAt
                                          .toString(),
                                      imageUrl:
                                          "${boom.boom.comments[index].user.photo!.isNotEmpty ? boom.boom.comments[index].user.photo : "https://icon-library.com/images/no-user-image-icon/no-user-image-icon-25.jpg"}",
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: getProportionateScreenHeight(5),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: TextFormField(
                                  controller: boomController.commentController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(12.0),
                                    fillColor: const Color(0xFFF8F8F8),
                                    filled: true,
                                    hintText: boom.boom.comments.isEmpty
                                        ? "No comments yet. Be the first"
                                        : "Type a Comment...",
                                    // prefixIcon: IconButton(
                                    //   icon: const Icon(
                                    //     MdiIcons.cameraOutline,
                                    //     color: Color(0xFF454C4D),
                                    //   ),
                                    //   onPressed: () {},
                                    // ),
                                    suffixIcon: SizedBox(
                                      width: getProportionateScreenWidth(100),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              await boomController
                                                  .commentOnPost(
                                                boomController
                                                    .commentController.text,
                                                boomId,
                                              );
                                              boomController.commentController
                                                  .clear();
                                            },
                                            child: boomController.commentLoading
                                                ? const CircularProgressIndicator(
                                                    color: kPrimaryColor,
                                                    strokeWidth: 2,
                                                  )
                                                : const Icon(
                                                    MdiIcons.send,
                                                    color: Color(0xFF454C4D),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black45,
                                        width: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black45,
                                        width: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.black45,
                                        width: 0.2,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text("Loading..."),
                );
              }
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
    );
  }
}
