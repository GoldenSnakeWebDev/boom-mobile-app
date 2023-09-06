import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/home_screen/controllers/single_boom_controller.dart';
import 'package:boom_mobile/screens/home_screen/services/single_boom_service.dart';
import 'package:boom_mobile/screens/other_user_profile/other_user_profile.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/single_comment_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/home_screen/models/all_booms.dart';

class SingleBoomPage extends StatefulWidget {
  const SingleBoomPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleBoomPage> createState() => _SingleBoomPageState();
}

class _SingleBoomPageState extends State<SingleBoomPage> {
  final GlobalKey _globalKey = GlobalKey();

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
  late HomeController homeCtrl;
  @override
  void initState() {
    homeCtrl = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kContBgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            homeCtrl.fetchAllBooms();
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
        child: RefreshIndicator(
          onRefresh: () async {
            boomController.refreshPage();
          },
          child: Container(
            padding: const EdgeInsets.all(6.0),
            height: SizeConfig.screenHeight * 0.87,
            width: SizeConfig.screenWidth,
            // margin: EdgeInsets.only(
            //     bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: SizeConfig.screenHeight * 0.87,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.4,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: boomController.boom.boomType == "text"
                              ? Text(
                                  "${boomController.boom.imageUrl}",
                                  style: TextStyle(
                                    fontSize: getProportionateScreenHeight(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : CachedNetworkImage(
                                  // height: getProportionateScreenHeight(200),
                                  width: SizeConfig.screenWidth,
                                  imageUrl: "${boomController.boom.imageUrl}",
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    height: getProportionateScreenHeight(200),
                                    width: SizeConfig.screenWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => const OtherUserProfileScreen(),
                                    arguments: boomController.boom.user!.id,
                                  );
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: CachedNetworkImage(
                                        height:
                                            getProportionateScreenHeight(45),
                                        width: getProportionateScreenHeight(45),
                                        imageUrl:
                                            "${boomController.boom.user!.photo!.isNotEmpty ? boomController.boom.user!.photo : "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/"}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: getProportionateScreenHeight(5),
                                    ),
                                    Text(
                                      "${boomController.boom.user!.username}",
                                      style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(11),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                    visible: boomController
                                        .boom.location!.isNotEmpty,
                                    child: Wrap(
                                      children: [
                                        const Icon(
                                          MdiIcons.mapMarker,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: SizeConfig.screenWidth * 0.2,
                                          child: Text(
                                            boomController.boom.location!,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        13),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height:
                                  //       getProportionateScreenHeight(5),
                                  // ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _onShare(context,
                                          boomController.boom.imageUrl!);
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton(
                                iconSize: getProportionateScreenWidth(45),
                                itemBuilder: (context) {
                                  return box.read("userId") ==
                                          boomController.boom.user!.id
                                      ? [
                                          PopupMenuItem(
                                            onTap: () async {
                                              Future.delayed(
                                                  const Duration(seconds: 0),
                                                  () async {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Delete Boom"),
                                                      content: const Text(
                                                          "Are you sure you want to delete this Boom?"),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Cancel"),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            await boomService
                                                                .deleteBoom(
                                                                    boomId);
                                                          },
                                                          child: const Text(
                                                              "Delete"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    kBlueColor.withOpacity(0.8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16.0, 4.0, 16.0, 4.0),
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                    color: Colors.white,
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
                                              if (boomController
                                                      .boom.boomState ==
                                                  BoomState.REAL_NFT) {
                                                Get
                                                    .snackbar("Error",
                                                        "You have already minted this boom as an NFT",
                                                        backgroundColor:
                                                            kredCancelTextColor,
                                                        colorText: Colors.white,
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM);
                                              } else {
                                                Future.delayed(
                                                    const Duration(seconds: 0),
                                                    () async {
                                                  Get.snackbar(
                                                    "Coming Soon",
                                                    "Hang in there, this feature will be available soon",
                                                    backgroundColor:
                                                        kPrimaryColor,
                                                    colorText: Colors.black,
                                                  );
                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder:
                                                  //       (BuildContext
                                                  //           context) {
                                                  //     return AlertDialog(
                                                  //       title: const Text(
                                                  //           "Export Boom"),
                                                  //       content: const Text(
                                                  //           "Please make sure you have selected the correct network in your wallet."),
                                                  //       actions: [
                                                  //         TextButton(
                                                  //           onPressed:
                                                  //               () {
                                                  //             Navigator.pop(
                                                  //                 context);
                                                  //           },
                                                  //           child: const Text(
                                                  //               "Cancel"),
                                                  //         ),
                                                  //         TextButton(
                                                  //           onPressed:
                                                  //               () async {
                                                  //             Get.back();
                                                  //             if (boom.boom
                                                  //                     .boomType ==
                                                  //                 "text") {
                                                  //               await _buildExportBottomSheet(
                                                  //                   boom.boom.imageUrl!,
                                                  //                   boom);
                                                  //             } else {
                                                  //               await boomController
                                                  //                   .exportBoom(
                                                  //                 boom
                                                  //                     .boom
                                                  //                     .network!
                                                  //                     .symbol,
                                                  //                 boom.boom
                                                  //                     .imageUrl!,
                                                  //                 boom.boom
                                                  //                     .title!,
                                                  //                 boom.boom
                                                  //                     .description!,
                                                  //                 boom.boom
                                                  //                     .id!,
                                                  //               );
                                                  //             }
                                                  //           },
                                                  //           child: const Text(
                                                  //               "Export"),
                                                  //         ),
                                                  //       ],
                                                  //     );
                                                  //   },
                                                  // );
                                                });
                                              }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    kBlueColor.withOpacity(0.8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16.0, 4.0, 16.0, 4.0),
                                                child: Text(
                                                  "Export",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                      : [
                                          PopupMenuItem(
                                            onTap: () async {
                                              //Function to synthetically Mint the NFT
                                              await boomController
                                                  .syntheticallyMintBoom(
                                                      boomController.boom.id!);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    kBlueColor.withOpacity(0.8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16.0, 4.0, 16.0, 4.0),
                                                child: Text(
                                                  "Syn. NFT",
                                                  style: TextStyle(
                                                    color: Colors.white,
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
                                                "Coming Soon",
                                                "Hang in there, this feature will be available soon",
                                                backgroundColor: kPrimaryColor,
                                                colorText: Colors.black,
                                              );

                                              // if (boom.boom.boomState ==
                                              //     BoomState.REAL_NFT) {
                                              //   Future.delayed(
                                              //       const Duration(
                                              //           seconds: 0),
                                              //       () {
                                              //     showDialog(
                                              //       context: context,
                                              //       builder:
                                              //           (BuildContext
                                              //               context) {
                                              //         return AlertDialog(
                                              //           title: const Text(
                                              //               "Connect Wallet"),
                                              //           content: const Text(
                                              //               "Please make sure you have selected the correct network in your wallet provider. "),
                                              //           actions: [
                                              //             TextButton(
                                              //               onPressed:
                                              //                   () {
                                              //                 Navigator.pop(
                                              //                     context);
                                              //               },
                                              //               child: const Text(
                                              //                   "Cancel"),
                                              //             ),
                                              //             TextButton(
                                              //               onPressed:
                                              //                   () async {
                                              //                 Get.back();
                                              //                 await boomController
                                              //                     .exportBoom(
                                              //                   boom
                                              //                       .boom
                                              //                       .network!
                                              //                       .symbol,
                                              //                   boom.boom
                                              //                       .imageUrl!,
                                              //                   boom.boom
                                              //                       .title!,
                                              //                   boom.boom
                                              //                       .description!,
                                              //                   boom.boom
                                              //                       .id!,
                                              //                 );
                                              //               },
                                              //               child: const Text(
                                              //                   "Proceed"),
                                              //             ),
                                              //           ],
                                              //         );
                                              //       },
                                              //     );
                                              //   });
                                              // } else {
                                              //   Get.snackbar("Error",
                                              //       "You can only synthetically mint this boom as an NFT",
                                              //       backgroundColor:
                                              //           kredCancelTextColor,
                                              //       colorText:
                                              //           Colors.white,
                                              //       snackPosition:
                                              //           SnackPosition
                                              //               .BOTTOM);
                                              // }
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    kBlueColor.withOpacity(0.8),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16.0, 4.0, 16.0, 4.0),
                                                child: Text(
                                                  "Mint NFT",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        getProportionateScreenHeight(
                                                            14),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ];
                                },
                                onSelected: (value) {
                                  log("Selected value $value");
                                },
                                icon: Container(
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      border: Border.all(color: Colors.black)),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                    child: FittedBox(
                                      child: Text(
                                        box.read("userId") ==
                                                boomController.boom.user!.id
                                            ? "More"
                                            : "Obtain",
                                        style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     log("User ID ${box.read("userId")}");
                              //     box.read("userId") ==
                              //             boom.boom.user!.id
                              //         ? showMenu(
                              //             context: context,
                              //             position:
                              //                 RelativeRect.fromLTRB(
                              //                     SizeConfig
                              //                             .screenWidth *
                              //                         0.6,
                              //                     SizeConfig
                              //                             .screenHeight *
                              //                         0.45,
                              //                     SizeConfig
                              //                             .screenWidth *
                              //                         0.35,
                              //                     60),
                              //             items: [
                              //               PopupMenuItem(
                              //                 onTap: () async {

                              //                   Future.delayed(
                              //                       const Duration(
                              //                           seconds: 0),
                              //                       () async {

                              //                     showDialog(
                              //                       context: context,
                              //                       builder:
                              //                           (BuildContext
                              //                               context) {
                              //                         return AlertDialog(
                              //                           title: const Text(
                              //                               "Delete Boom"),
                              //                           content: const Text(
                              //                               "Are you sure you want to delete this Boom?"),
                              //                           actions: [
                              //                             TextButton(
                              //                               onPressed:
                              //                                   () {
                              //                                 Navigator.pop(
                              //                                     context);
                              //                               },
                              //                               child: const Text(
                              //                                   "Cancel"),
                              //                             ),
                              //                             TextButton(
                              //                               onPressed:
                              //                                   () async {
                              //                                 await boomService
                              //                                     .deleteBoom(
                              //                                         boomId);
                              //                               },
                              //                               child: const Text(
                              //                                   "Delete"),
                              //                             ),
                              //                           ],
                              //                         );
                              //                       },
                              //                     );
                              //                   });
                              //                 },
                              //                 child: Container(
                              //                   decoration:
                              //                       BoxDecoration(
                              //                     color: kBlueColor
                              //                         .withOpacity(0.8),
                              //                   ),
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets
                              //                                 .fromLTRB(
                              //                             16.0,
                              //                             4.0,
                              //                             16.0,
                              //                             4.0),
                              //                     child: Text(
                              //                       "Delete",
                              //                       style: TextStyle(
                              //                         color:
                              //                             Colors.white,
                              //                         fontSize:
                              //                             getProportionateScreenHeight(
                              //                                 14),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               PopupMenuItem(
                              //                 onTap: () async {
                              //                   if (boom.boom
                              //                           .boomState ==
                              //                       BoomState
                              //                           .REAL_NFT) {
                              //                     Get.snackbar("Error",
                              //                         "You have already minted this boom as an NFT",
                              //                         backgroundColor:
                              //                             kredCancelTextColor,
                              //                         colorText:
                              //                             Colors.white,
                              //                         snackPosition:
                              //                             SnackPosition
                              //                                 .BOTTOM);
                              //                   } else {
                              //                     Future.delayed(
                              //                         const Duration(
                              //                             seconds: 0),
                              //                         () async {
                              //                       showDialog(
                              //                         context: context,
                              //                         builder:
                              //                             (BuildContext
                              //                                 context) {
                              //                           return AlertDialog(
                              //                             title: const Text(
                              //                                 "Export Boom"),
                              //                             content:
                              //                                 const Text(
                              //                                     "Please make sure you have selected the correct network in your wallet."),
                              //                             actions: [
                              //                               TextButton(
                              //                                 onPressed:
                              //                                     () {
                              //                                   Navigator.pop(
                              //                                       context);
                              //                                 },
                              //                                 child: const Text(
                              //                                     "Cancel"),
                              //                               ),
                              //                               TextButton(
                              //                                 onPressed:
                              //                                     () async {
                              //                                   Get.back();
                              //                                   await boomController
                              //                                       .exportBoom(
                              //                                     boom
                              //                                         .boom
                              //                                         .network!
                              //                                         .symbol,
                              //                                     boom.boom
                              //                                         .imageUrl!,
                              //                                     boom.boom
                              //                                         .title!,
                              //                                     boom.boom
                              //                                         .description!,
                              //                                     boom.boom
                              //                                         .id!,
                              //                                   );
                              //                                 },
                              //                                 child: const Text(
                              //                                     "Export"),
                              //                               ),
                              //                             ],
                              //                           );
                              //                         },
                              //                       );
                              //                     });
                              //                   }
                              //                 },
                              //                 child: Container(
                              //                   decoration:
                              //                       BoxDecoration(
                              //                     color: kBlueColor
                              //                         .withOpacity(0.8),
                              //                   ),
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets
                              //                                 .fromLTRB(
                              //                             16.0,
                              //                             4.0,
                              //                             16.0,
                              //                             4.0),
                              //                     child: Text(
                              //                       "Export",
                              //                       style: TextStyle(
                              //                         color:
                              //                             Colors.white,
                              //                         fontSize:
                              //                             getProportionateScreenHeight(
                              //                                 14),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           )
                              //         : showMenu(
                              //             context: context,
                              //             position:
                              //                 RelativeRect.fromLTRB(
                              //               SizeConfig.screenWidth *
                              //                   0.6,
                              //               SizeConfig.screenHeight *
                              //                   0.45,
                              //               SizeConfig.screenWidth *
                              //                   0.35,
                              //               60,
                              //             ),
                              //             constraints: BoxConstraints(
                              //                 maxWidth: SizeConfig
                              //                         .screenWidth *
                              //                     0.35),
                              //             shape: RoundedRectangleBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(
                              //                       8.0),
                              //             ),
                              //             items: [
                              //               PopupMenuItem(
                              //                 onTap: () async {
                              //                   //Function to synthetically Mint the NFT
                              //                   await boomController
                              //                       .syntheticallyMintBoom(
                              //                           boom.boom.id!);
                              //                 },
                              //                 child: Container(
                              //                   decoration:
                              //                       BoxDecoration(
                              //                     color: kBlueColor
                              //                         .withOpacity(0.8),
                              //                   ),
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets
                              //                                 .fromLTRB(
                              //                             16.0,
                              //                             4.0,
                              //                             16.0,
                              //                             4.0),
                              //                     child: Text(
                              //                       "Syn. NFT",
                              //                       style: TextStyle(
                              //                         color:
                              //                             Colors.white,
                              //                         fontSize:
                              //                             getProportionateScreenHeight(
                              //                                 14),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //               PopupMenuItem(
                              //                 onTap: () async {
                              //                   if (boom.boom
                              //                           .boomState ==
                              //                       BoomState
                              //                           .REAL_NFT) {
                              //                     Future.delayed(
                              //                         const Duration(
                              //                             seconds: 0),
                              //                         () {
                              //                       showDialog(
                              //                         context: context,
                              //                         builder:
                              //                             (BuildContext
                              //                                 context) {
                              //                           return AlertDialog(
                              //                             title: const Text(
                              //                                 "Connect Wallet"),
                              //                             content:
                              //                                 const Text(
                              //                                     "Please make sure you have selected the correct network in your wallet provider. "),
                              //                             actions: [
                              //                               TextButton(
                              //                                 onPressed:
                              //                                     () {
                              //                                   Navigator.pop(
                              //                                       context);
                              //                                 },
                              //                                 child: const Text(
                              //                                     "Cancel"),
                              //                               ),
                              //                               TextButton(
                              //                                 onPressed:
                              //                                     () async {
                              //                                   Get.back();
                              //                                   await boomController
                              //                                       .exportBoom(
                              //                                     boom
                              //                                         .boom
                              //                                         .network!
                              //                                         .symbol,
                              //                                     boom.boom
                              //                                         .imageUrl!,
                              //                                     boom.boom
                              //                                         .title!,
                              //                                     boom.boom
                              //                                         .description!,
                              //                                     boom.boom
                              //                                         .id!,
                              //                                   );
                              //                                 },
                              //                                 child: const Text(
                              //                                     "Proceed"),
                              //                               ),
                              //                             ],
                              //                           );
                              //                         },
                              //                       );
                              //                     });
                              //                   } else {
                              //                     Get.snackbar("Error",
                              //                         "You can only synthetically mint this boom as an NFT",
                              //                         backgroundColor:
                              //                             kredCancelTextColor,
                              //                         colorText:
                              //                             Colors.white,
                              //                         snackPosition:
                              //                             SnackPosition
                              //                                 .BOTTOM);
                              //                   }
                              //                 },
                              //                 child: Container(
                              //                   decoration:
                              //                       BoxDecoration(
                              //                     color: kBlueColor
                              //                         .withOpacity(0.8),
                              //                   ),
                              //                   child: Padding(
                              //                     padding:
                              //                         const EdgeInsets
                              //                                 .fromLTRB(
                              //                             16.0,
                              //                             4.0,
                              //                             16.0,
                              //                             4.0),
                              //                     child: Text(
                              //                       "Mint NFT",
                              //                       style: TextStyle(
                              //                         color:
                              //                             Colors.white,
                              //                         fontSize:
                              //                             getProportionateScreenHeight(
                              //                                 14),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           );
                              //   },
                              //   child: Container(
                              //     decoration: BoxDecoration(
                              //         color: kPrimaryColor,
                              //         border: Border.all(
                              //             color: Colors.black)),
                              //     child: Padding(
                              //       padding: const EdgeInsets.fromLTRB(
                              //           10, 4, 10, 4),
                              //       child: Text(
                              //         box.read("userId") ==
                              //                 boom.boom.user!.id
                              //             ? "More"
                              //             : "Obtain",
                              //         style: TextStyle(
                              //           fontSize:
                              //               getProportionateScreenHeight(
                              //                   12),
                              //           fontWeight: FontWeight.w900,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "${boomController.boom.price!} ${boomController.boom.network!.symbol}",
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(13),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    "( \$${boomController.boom.fixedPrice} )",
                                    style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(11),
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(10),
                              ),
                              CachedNetworkImage(
                                height: getProportionateScreenHeight(16),
                                width: getProportionateScreenWidth(16),
                                imageUrl: boomController.boom.network!.imageUrl
                                            .toString() ==
                                        "https://polygon.technology/favicon-32x32.png"
                                    ? "http://boomhost.xyz/backend/LOGOS/polygon-matic-logo.png"
                                    : boomController.boom.network!.symbol
                                                .toString() ==
                                            "TZ"
                                        ? "https://tezos.com/favicon-32x32.png"
                                        : boomController.boom.network!.imageUrl
                                            .toString(),
                                useOldImageOnUrlChange: true,
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  "assets/icons/matic.png",
                                  width: getProportionateScreenWidth(20),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showMenu(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    position: RelativeRect.fromLTRB(
                                      SizeConfig.screenWidth,
                                      SizeConfig.screenHeight * 0.45,
                                      30,
                                      60,
                                    ),
                                    items: [
                                      PopupMenuItem(
                                        onTap: () async {
                                          switch (boomController
                                              .boom.network!.symbol) {
                                            case "BNB":
                                              await launchUrl(
                                                  Uri.parse(
                                                    "https://bscscan.com/address/$bnbTokenAddress",
                                                  ),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                  webOnlyWindowName:
                                                      "Binance Explorer");
                                              break;
                                            case "MATIC":
                                              await launchUrl(
                                                  Uri.parse(
                                                    "https://polygonscan.com/address/$maticTokenAddress",
                                                  ),
                                                  mode: LaunchMode
                                                      .externalApplication,
                                                  webOnlyWindowName:
                                                      "Polygon Explorer");
                                              break;
                                            default:
                                          }
                                        },
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
                        boomController.boom.description!,
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(16),
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Row(
                        children: boomController.boom.tags!
                            .map((e) => Text(e,
                                style: TextStyle(
                                    fontSize: getProportionateScreenHeight(11),
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700)))
                            .toList(),
                      ),
                      // Text(
                      //   boom.boom.tags![0],
                      //   style: TextStyle(
                      //       fontSize: getProportionateScreenHeight(11),
                      //       color: Colors.blue,
                      //       fontWeight: FontWeight.w700),
                      // ),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),

                      //Ractions Section
                      //TODO: Change this to a widget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Obx(
                                () => LikeButton(
                                  animationDuration:
                                      const Duration(milliseconds: 500),
                                  size: getProportionateScreenHeight(28),
                                  bubblesColor: const BubblesColor(
                                      dotPrimaryColor: kPrimaryColor,
                                      dotSecondaryColor: kSecondaryColor),
                                  isLiked: boomController.isLikes.value,
                                  onTap: (isLiked) async {
                                    boomController.reactToBoom(
                                        "likes", boomId, boomController.boom);

                                    return !boomController.isLikes.value;
                                  },
                                  likeCount: boomController.likesCount,
                                  countPostion: CountPostion.bottom,
                                  likeBuilder: (bool isLiked) {
                                    log("Like Value${boomController.isLikes.value}");
                                    return CachedNetworkImage(
                                      height: getProportionateScreenHeight(26),
                                      color: boomController.isLikes.value
                                          ? kPrimaryColor
                                          : Colors.black,
                                      imageUrl: likeIconUrl,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          // Column(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Obx(
                          //       () => LikeButton(
                          //         animationDuration:
                          //             const Duration(milliseconds: 600),
                          //         size:
                          //             getProportionateScreenHeight(22),
                          //         bubblesColor: const BubblesColor(
                          //             dotPrimaryColor: kPrimaryColor,
                          //             dotSecondaryColor:
                          //                 kSecondaryColor),
                          //         isLiked: boomController.isLoves.value,
                          //         onTap: (isLoved) async {
                          //           boomController.reactToBoom(
                          //               "loves", boomId, boom);

                          //           return boomController.isLoves.value;
                          //         },
                          //         likeCount: boomController.lovesCount,
                          //         countPostion: CountPostion.bottom,
                          //         likeBuilder: ((isLoves) {
                          //           return SvgPicture.asset(
                          //             height:
                          //                 getProportionateScreenHeight(
                          //                     15),
                          //             "assets/icons/love.svg",
                          //             color:
                          //                 boomController.isLoves.value
                          //                     ? Colors.red
                          //                     : Colors.grey,
                          //           );
                          //         }),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Obx(
                          //       () => LikeButton(
                          //         animationDuration:
                          //             const Duration(milliseconds: 600),
                          //         size:
                          //             getProportionateScreenHeight(26),
                          //         bubblesColor: const BubblesColor(
                          //             dotPrimaryColor: kPrimaryColor,
                          //             dotSecondaryColor:
                          //                 kSecondaryColor),
                          //         isLiked:
                          //             boomController.isSmiles.value,
                          //         onTap: (isLiked) async {
                          //           boomController.reactToBoom(
                          //               "smiles", boomId, boom);

                          //           return boomController
                          //               .isSmiles.value;
                          //         },
                          //         likeCount: boomController.smilesCount,
                          //         countPostion: CountPostion.bottom,
                          //         likeBuilder: ((isLiked) {
                          //           return boomController.isSmiles.value
                          //               ? CachedNetworkImage(
                          //                   height:
                          //                       getProportionateScreenHeight(
                          //                           26),
                          //                   imageUrl: smileIconUrl,
                          //                 )
                          //               : CachedNetworkImage(
                          //                   height:
                          //                       getProportionateScreenHeight(
                          //                           26),
                          //                   imageUrl: smileIconUrl,
                          //                   color: Colors.grey,
                          //                 );
                          //         }),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Obx(
                          //       () => LikeButton(
                          //           animationDuration: const Duration(
                          //               milliseconds: 600),
                          //           size: getProportionateScreenHeight(
                          //               20),
                          //           isLiked:
                          //               boomController.isRebooms.value,
                          //           onTap: (isLiked) async {
                          //             boomController.reactToBoom(
                          //                 "rebooms", boomId, boom);

                          //             return boomController
                          //                 .isRebooms.value;
                          //           },
                          //           likeCount:
                          //               boomController.reboomsCount,
                          //           countPostion: CountPostion.bottom,
                          //           bubblesColor: const BubblesColor(
                          //               dotPrimaryColor: kPrimaryColor,
                          //               dotSecondaryColor:
                          //                   kSecondaryColor),
                          //           likeBuilder: (isLiked) {
                          //             return SvgPicture.asset(
                          //               height:
                          //                   getProportionateScreenHeight(
                          //                       18),
                          //               "assets/icons/reboom.svg",
                          //               color: isLiked
                          //                   ? kPrimaryColor
                          //                   : Colors.grey,
                          //             );
                          //           }),
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   children: [
                          //     Obx(
                          //       () => LikeButton(
                          //         animationDuration:
                          //             const Duration(milliseconds: 600),
                          //         size:
                          //             getProportionateScreenHeight(20),
                          //         isLiked:
                          //             boomController.isReports.value,
                          //         onTap: (isReports) async {
                          //           boomController.reactToBoom(
                          //               "reports", boomId, boom);
                          //           return null;
                          //         },
                          //         bubblesColor: const BubblesColor(
                          //             dotPrimaryColor: kPrimaryColor,
                          //             dotSecondaryColor:
                          //                 kSecondaryColor),
                          //         likeBuilder: ((isLiked) {
                          //           return Icon(
                          //             MdiIcons.alert,
                          //             color: isLiked
                          //                 ? kYellowTextColor
                          //                 : Colors.grey,
                          //           );
                          //         }),
                          //       ),
                          //     ),
                          //     Text(
                          //       boomController.reportsCount.toString(),
                          //       style: TextStyle(
                          //         fontSize:
                          //             getProportionateScreenHeight(12),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Column(
                          //   mainAxisAlignment:
                          //       MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     LikeButton(
                          //       animationDuration:
                          //           const Duration(milliseconds: 600),
                          //       size: getProportionateScreenHeight(20),
                          //       onTap: (_) async {
                          //         FocusScope.of(context).requestFocus(
                          //             boomController.commentFocusNode);
                          //         return null;
                          //         // return null;
                          //       },
                          //       bubblesColor: const BubblesColor(
                          //           dotPrimaryColor: kPrimaryColor,
                          //           dotSecondaryColor: kSecondaryColor),
                          //       likeBuilder: ((isLiked) {
                          //         return const Icon(
                          //           MdiIcons.chatOutline,
                          //           size: 22,
                          //         );
                          //       }),
                          //     ),
                          //     Text(
                          //       "${boom.boom.comments!.length}",
                          //       style: TextStyle(
                          //         fontSize:
                          //             getProportionateScreenHeight(12),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
                      ),
                      //View Comments Section
                      StreamBuilder(
                          stream: boomService.getSingleBoom(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return boomController.boom.comments!.isEmpty
                                  ? const Center(
                                      child: Text("Could not fecch comments"),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount:
                                          boomController.boom.comments!.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return SingleComment(
                                          comment: boomController
                                              .boom.comments![index].message!,
                                          userName: boomController.boom
                                              .comments![index].user!.username!,
                                          createdAt: boomController
                                              .boom.comments![index].createdAt
                                              .toString(),
                                          imageUrl:
                                              "${boomController.boom.comments![index].user!.photo!.isNotEmpty ? boomController.boom.comments![index].user!.photo : "https://icon-library.com/images/no-user-image-icon/no-user-image-icon-25.jpg"}",
                                          userId: boomController
                                              .boom.comments![index].user!.id!,
                                        );
                                      },
                                    );
                            } else if (snapshot.connectionState ==
                                    ConnectionState.active ||
                                snapshot.connectionState ==
                                    ConnectionState.done) {
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Could not fecch comments"),
                                );
                              } else if (snapshot.hasData) {
                                Boom? boom = snapshot.data;
                                return boom!.comments!.isEmpty
                                    ? const Center(
                                        child: Text("No comments yet"),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: boom.comments!.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return SingleComment(
                                            comment:
                                                boom.comments![index].message!,
                                            userName: boom.comments![index]
                                                .user!.username!,
                                            createdAt: boom
                                                .comments![index].createdAt
                                                .toString(),
                                            imageUrl:
                                                "${boom.comments![index].user!.photo!.isNotEmpty ? boom.comments![index].user!.photo : "https://icon-library.com/images/no-user-image-icon/no-user-image-icon-25.jpg"}",
                                            userId:
                                                boom.comments![index].user!.id!,
                                          );
                                        },
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
                          }),
                      SizedBox(height: getProportionateScreenHeight(7)),
                      const Spacer(),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: TextFormField(
                            controller: boomController.commentController,
                            focusNode: boomController.commentFocusNode,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(12.0),

                              fillColor: const Color(0xFFF8F8F8),
                              filled: true,
                              hintText: boomController.boom.comments!.isEmpty
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await boomController.commentOnPost(
                                          boomController.commentController.text,
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
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildExportBottomSheet(String textNFT, Boom boom) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return Container(
            height: getProportionateScreenHeight(300),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                          width: SizeConfig.screenWidth * 0.85,
                          height: getProportionateScreenHeight(200),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: kPrimaryColor,
                              width: 0.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            textNFT,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontSize: getProportionateScreenHeight(20),
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _convertTextToImage(boom);
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.8,
                      height: getProportionateScreenHeight(40),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[400],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          "Export NFT",
                          style: TextStyle(
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _convertTextToImage(Boom boom) async {
    EasyLoading.show(status: 'Generating Image...');
    try {
      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Directory dir = await getApplicationDocumentsDirectory();
      String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = '${dir.path}/$timeStamp.png';
      File selectedIgImage = File(filePath);

      var pngBytes = byteData!.buffer.asUint8List().toList();
      await selectedIgImage.writeAsBytes(pngBytes);
      // var base64 = base64Decode(pngBytes.toString());
      final result = await selectedIgImage.exists();

      Get.back();
      if (result) {
        EasyLoading.dismiss();
        await boomController.exportBoom(
          boom.network!.symbol!,
          boom.imageUrl!,
          boom.title!,
          boom.description!,
          boom.id!,
        );
      } else {
        EasyLoading.dismiss();
        Get.snackbar(
          "Error",
          "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }

      return pngBytes;
    } catch (e) {
      log("Error Occured $e");
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}

class GeneratedImageScreen extends StatelessWidget {
  final String file;
  const GeneratedImageScreen({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.file(
            File(file),
            width: SizeConfig.screenWidth * 0.8,
            height: SizeConfig.screenHeight,
          ),
        ),
      ),
    );
  }
}
