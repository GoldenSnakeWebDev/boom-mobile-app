import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/authentication/login/models/user_model.dart';
import 'package:boom_mobile/screens/fans_frens_screen/ui/fans_screen.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/profile_controller.dart';
import 'package:boom_mobile/screens/profile_screen/ui/boom_box.dart';
import 'package:boom_mobile/screens/profile_screen/ui/edit_profile.dart';
import 'package:boom_mobile/screens/profile_screen/service/profile_service.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    Get.put(ProfileController());

    super.initState();
  }

  final boomController = Get.find<HomeController>();
  final profileService = ProfileService();

  @override
  Widget build(BuildContext context) {
    // return GetBuilder<ProfileController>(builder: (controller) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: SizeConfig.screenHeight,
            maxWidth: SizeConfig.screenWidth,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GetBuilder<ProfileController>(builder: (controller) {
                return Expanded(
                  child: NestedScrollView(
                    controller: _scrollController,
                    headerSliverBuilder: (context, value) {
                      return [
                        // SliverPersistentHeader(
                        //   delegate: SliverAppBarDelegate(
                        //     maxHeight: SizeConfig.screenHeight * 0.25,
                        //     minHeight: SizeConfig.screenHeight * 0.09,
                        //   ),
                        // ),

                        SliverToBoxAdapter(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await controller.fetchMyBooms();
                            },
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: SizeConfig.screenHeight * 0.47,
                                maxWidth: SizeConfig.screenWidth,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  StreamBuilder(
                                    stream: profileService.fetchMyProfile(),
                                    builder: ((context,
                                        AsyncSnapshot<User?> snapshot) {
                                      User? user = snapshot.data;
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return SizedBox(
                                          width: SizeConfig.screenWidth,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.blueGrey.shade100,
                                            highlightColor: Colors.white,
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: SizeConfig.screenWidth,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          34),
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          2),
                                                ),
                                                Container(
                                                  width: SizeConfig.screenWidth,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          125),
                                                  color: Colors.white,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width:
                                                            getProportionateScreenWidth(
                                                                70),
                                                        height:
                                                            getProportionateScreenHeight(
                                                                35),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      } else if (snapshot.connectionState ==
                                              ConnectionState.active ||
                                          snapshot.connectionState ==
                                              ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return const Center(
                                            child: Text(
                                                "Could not fecch user profile"),
                                          );
                                        }
                                        return Column(
                                          children: [
                                            Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                                  getProportionateScreenHeight(
                                                      34),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 6.0,
                                                    bottom: 6.0,
                                                    right: 10.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      MdiIcons.mapMarker,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              30),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.black,
                                                      ),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0,
                                                                right: 4.0),
                                                        child: Text(
                                                          user?.location ??
                                                              "Location",
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      "!${user?.username ?? "username"}",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            getProportionateScreenHeight(
                                                                15),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () => Get.to(
                                                          () =>
                                                              const EditProfile(),
                                                          arguments: [user]),
                                                      child: const Icon(
                                                        MdiIcons
                                                            .accountEditOutline,
                                                        size: 24,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: SizeConfig.screenHeight *
                                                  0.29,
                                              child: Stack(
                                                children: [
                                                  user!.cover!.isEmpty
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            Get.to(
                                                                () =>
                                                                    const EditProfile(),
                                                                arguments: [
                                                                  user
                                                                ]);
                                                          },
                                                          child: Container(
                                                            width: SizeConfig
                                                                .screenWidth,
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    125),
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color:
                                                                        kContBgColor),
                                                            child:
                                                                ConstrainedBox(
                                                              constraints:
                                                                  BoxConstraints(
                                                                maxHeight:
                                                                    getProportionateScreenHeight(
                                                                        125),
                                                                maxWidth: SizeConfig
                                                                    .screenWidth,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Add header Image",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          getProportionateScreenHeight(
                                                                              14),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        getProportionateScreenHeight(
                                                                            10),
                                                                  ),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            color: Colors
                                                                                .black26),
                                                                        shape: BoxShape
                                                                            .circle),
                                                                    child:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .add,
                                                                        size:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          width: SizeConfig
                                                              .screenWidth,
                                                          height:
                                                              getProportionateScreenHeight(
                                                                  125),
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  NetworkImage(
                                                                user.cover!,
                                                              ),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                  Positioned(
                                                    right: 0,
                                                    child: Container(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              145),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              30),
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.white),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {
                                                              await launchUrl(
                                                                Uri.parse(
                                                                  "https://twitter.com/${user.socialMedia!.twitter!}",
                                                                ),
                                                              );
                                                            },
                                                            child: Icon(
                                                              MdiIcons.twitter,
                                                              size: 18,
                                                              color: user
                                                                      .socialMedia!
                                                                      .twitter!
                                                                      .isEmpty
                                                                  ? Colors
                                                                      .black26
                                                                  : Colors
                                                                      .blueAccent,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              String url = user
                                                                      .socialMedia!
                                                                      .facebook!
                                                                      .contains(
                                                                          "https")
                                                                  ? user
                                                                      .socialMedia!
                                                                      .facebook!
                                                                      .toString()
                                                                  : "https://www.facebook.com/${user.socialMedia!.facebook}";
                                                              await launchUrl(
                                                                Uri.parse(
                                                                  url,
                                                                ),
                                                              );
                                                            },
                                                            child: Icon(
                                                              MdiIcons.facebook,
                                                              size: 18,
                                                              color: user
                                                                      .socialMedia!
                                                                      .facebook!
                                                                      .isEmpty
                                                                  ? Colors.grey
                                                                  : Colors.blue,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              await launchUrl(
                                                                Uri.parse(
                                                                  "https://instagram.com/${user.socialMedia!.instagram}",
                                                                ),
                                                              );
                                                            },
                                                            child: Icon(
                                                              MdiIcons
                                                                  .instagram,
                                                              size: 18,
                                                              color: user
                                                                      .socialMedia!
                                                                      .instagram!
                                                                      .isEmpty
                                                                  ? Colors
                                                                      .black26
                                                                  : Colors
                                                                      .purpleAccent,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              await launchUrl(
                                                                Uri.parse(
                                                                  "https://tiktok.com/@${user.socialMedia!.tiktok}",
                                                                ),
                                                              );
                                                            },
                                                            child: Icon(
                                                              MdiIcons
                                                                  .musicNote,
                                                              size: 18,
                                                              color: user
                                                                      .socialMedia!
                                                                      .tiktok!
                                                                      .isEmpty
                                                                  ? Colors
                                                                      .black26
                                                                  : Colors
                                                                      .pinkAccent,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
                                                              String url = user
                                                                      .socialMedia!
                                                                      .medium!
                                                                      .contains(
                                                                          "https://")
                                                                  ? user
                                                                      .socialMedia!
                                                                      .medium
                                                                      .toString()
                                                                  : "https://www.medium.com/@${user.socialMedia!.medium}";
                                                              await launchUrl(
                                                                Uri.parse(
                                                                  url,
                                                                ),
                                                              );
                                                            },
                                                            child: SvgPicture
                                                                .asset(
                                                              "assets/icons/medium_icon_1.svg",
                                                              width: 18,
                                                              color: user
                                                                      .socialMedia!
                                                                      .medium!
                                                                      .isEmpty
                                                                  ? Colors
                                                                      .black12
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 95,
                                                    left: 15,
                                                    child: SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              60),
                                                      height:
                                                          getProportionateScreenHeight(
                                                              70),
                                                      child: Stack(
                                                        children: [
                                                          Positioned(
                                                            top: 10,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                border:
                                                                    Border.all(
                                                                  color: Colors
                                                                      .black12,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              width:
                                                                  getProportionateScreenWidth(
                                                                      55),
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      60),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child: Image
                                                                    .network(
                                                                  height:
                                                                      getProportionateScreenHeight(
                                                                          60),
                                                                  width:
                                                                      getProportionateScreenWidth(
                                                                          55),
                                                                  user.photo!
                                                                          .isEmpty
                                                                      ? "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/"
                                                                      : user
                                                                          .photo!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Visibility(
                                                            visible:
                                                                user.isAdmin!,
                                                            child: Positioned(
                                                              top: 0,
                                                              right: 0,
                                                              child: Container(
                                                                width:
                                                                    getProportionateScreenWidth(
                                                                        20),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white,
                                                                      width: 1),
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color:
                                                                      kBlueColor,
                                                                ),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          3.0),
                                                                  child: Text(
                                                                    "B",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w900,
                                                                      fontSize:
                                                                          getProportionateScreenHeight(
                                                                              14),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 150,
                                                    left: 110,
                                                    child: SizedBox(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              250),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 12),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "${controller.myBooms?.booms?.length ?? 0}",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontSize:
                                                                            getProportionateScreenHeight(16),
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Booms",
                                                                      style:
                                                                          TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            getProportionateScreenHeight(12),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      getProportionateScreenWidth(
                                                                          40),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(
                                                                        () =>
                                                                            const FansScreen(),
                                                                        arguments: [
                                                                          user.funs!,
                                                                          "Fans"
                                                                        ]);
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        user.funs?.length.toString() ??
                                                                            "0",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w900,
                                                                          fontSize:
                                                                              getProportionateScreenHeight(16),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Fans",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              getProportionateScreenHeight(12),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      getProportionateScreenWidth(
                                                                          40),
                                                                ),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    Get.to(
                                                                        () =>
                                                                            const FansScreen(),
                                                                        arguments: [
                                                                          user.friends!,
                                                                          "Frens"
                                                                        ]);
                                                                  },
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        user.friends!
                                                                            .length
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontSize:
                                                                              getProportionateScreenHeight(16),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        "Frens",
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontSize:
                                                                              getProportionateScreenHeight(12),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  getProportionateScreenHeight(
                                                                      4),
                                                            ),
                                                            user.bio!.isEmpty
                                                                ? TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.to(
                                                                          () =>
                                                                              const EditProfile(),
                                                                          arguments: [
                                                                            user
                                                                          ]);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "You have no Bio yet please add one",
                                                                    ),
                                                                  )
                                                                : ReadMoreText(
                                                                    user.bio!,
                                                                    numLines: 2,
                                                                    onReadMoreClicked:
                                                                        () {
                                                                    controller
                                                                        .changeFontSize();
                                                                  },
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            controller
                                                                                .bioFontSize),
                                                                    readMoreIcon:
                                                                        const SizedBox(),
                                                                    readLessIcon:
                                                                        const SizedBox(),
                                                                    readMoreText:
                                                                        "See More",
                                                                    readLessText:
                                                                        "Read Less")

                                                            // Text(
                                                            //     user.bio!,
                                                            //     overflow:
                                                            //         TextOverflow
                                                            //             .ellipsis,
                                                            //   )

                                                            // const ListTile(
                                                            //   leading: Icon(MdiIcons.circleSmall),
                                                            // )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 220,
                                                    left: 30,
                                                    child: Container(
                                                      width:
                                                          getProportionateScreenWidth(
                                                              22),
                                                      height:
                                                          getProportionateScreenHeight(
                                                              22),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.black),
                                                        gradient:
                                                            const LinearGradient(
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .bottomRight,
                                                          colors: [
                                                            kPrimaryColor,
                                                            kSecondaryColor,
                                                          ],
                                                        ),
                                                      ),
                                                      child: const Icon(
                                                        MdiIcons.swapVertical,
                                                        size: 18,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 180,
                                                    left: 30,
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          _showComingSoon(),
                                                      child: Image.network(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                26),
                                                        "https://bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy.ipfs.nftstorage.link/noob_talk.png",
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return const Center(
                                          child: Text("Error fetching profile"),
                                        );
                                      }
                                    }),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: kContBgColor,
                                      width: SizeConfig.screenWidth,
                                      // height: getProportionateScreenHeight(130),
                                      alignment: Alignment.center,
                                      child: GridView.builder(
                                        padding: EdgeInsets.symmetric(
                                          horizontal:
                                              getProportionateScreenWidth(10),
                                          vertical:
                                              getProportionateScreenHeight(10),
                                        ),
                                        itemCount: profileOptions.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 3,
                                          crossAxisSpacing: 5,
                                          mainAxisSpacing: 10,
                                        ),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller
                                                  .changeSelectedIndex(index);
                                            },
                                            child: Container(
                                              width:
                                                  getProportionateScreenWidth(
                                                      70),
                                              // height:
                                              //     getProportionateScreenHeight(
                                              //         18),
                                              margin: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                gradient: index ==
                                                        controller.selectedTab
                                                    ? const LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment
                                                            .bottomRight,
                                                        colors: [
                                                          kSecondaryColor,
                                                          kPrimaryColor,
                                                          kPrimaryColor,
                                                          kPrimaryColor,
                                                          kSecondaryColor
                                                        ],
                                                      )
                                                    : null,
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                profileOptions[index],
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize:
                                                      getProportionateScreenHeight(
                                                          12),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: SizeConfig.screenHeight * 0.2,
                                  //   child: Stack(
                                  //     children: [
                                  // Positioned(
                                  //   top: 180,
                                  //   right: 30,
                                  //   child: SvgPicture.asset(
                                  //     height:
                                  //         getProportionateScreenHeight(22),
                                  //     "assets/icons/tip.svg",
                                  //   ),
                                  // ),
                                  // Positioned(
                                  //   top: 220,
                                  //   right: 30,
                                  //   child: Image.network(
                                  //     height:
                                  //         getProportionateScreenHeight(22),
                                  //     "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/nudge.png",
                                  //   ),
                                  // ),

                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ];
                    },
                    body: controller.selectedTab == 2
                        ? const BoomBoxScreen()
                        : Container(
                            color: kContBgColor,
                            constraints: BoxConstraints(
                              minHeight: SizeConfig.screenHeight * 0.38,
                            ),
                            height: SizeConfig.screenHeight * 0.39,
                            width: SizeConfig.screenWidth,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: controller.isLoadingBooms
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : controller.myBooms!.booms!.isEmpty
                                      ? Center(
                                          child: Text(
                                            "You have no Booms Yet",
                                            style: TextStyle(
                                                fontSize:
                                                    getProportionateScreenHeight(
                                                        17),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount:
                                              controller.myBooms!.booms!.length,
                                          itemBuilder: (context, index) {
                                            //Temp Solutiuon to change this later to only my Booms

                                            SingleBoomPost boomPost =
                                                controller.getSingleBoomDetails(
                                                    controller
                                                        .myBooms!.booms![index],
                                                    index);
                                            return SingleBoomWidget(
                                              post: boomPost,
                                              controller:
                                                  Get.find<HomeController>(),
                                              boomId: controller
                                                  .myBooms!.booms![index].id!,
                                            );
                                          },
                                        ),
                            ),
                          ),
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchSocial(String url) async {
    var uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  _showComingSoon() {
    Get.snackbar(
      "Hang in there.",
      "Shipping soon..",
      backgroundColor: kPrimaryColor,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.black,
      overlayBlur: 5.0,
      margin: EdgeInsets.only(
        top: SizeConfig.screenHeight * 0.05,
        left: SizeConfig.screenWidth * 0.05,
        right: SizeConfig.screenWidth * 0.05,
      ),
    );
  }
}
