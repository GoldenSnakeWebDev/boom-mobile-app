import 'dart:developer';

import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/fans_frens_screen/ui/fans_screen.dart';

import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/other_user_profile/controllers/other_profile_controller.dart';
import 'package:boom_mobile/screens/other_user_profile/models/other_user_booms.dart';
import 'package:boom_mobile/screens/other_user_profile/models/other_user_model.dart';
import 'package:boom_mobile/screens/other_user_profile/services/other_profile_service.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({Key? key}) : super(key: key);

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  late String userId;
  late String myUserId;
  final box = GetStorage();
  @override
  void initState() {
    // Get.put(OtherUserProfileController());
    userId = Get.arguments;
    myUserId = box.read("userId");
    log("My User Id $myUserId");
    super.initState();
    Get.put(OtherUserProfileController());
  }

  int boomCount = 0;
  final boomController = Get.find<HomeController>();
  final otherProfileService = OtherProfileService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          leadingWidget: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            ),
          ),
        ),
        body: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: SizeConfig.screenHeight,
              maxWidth: SizeConfig.screenWidth,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
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
                                // await controller.fetchProfile();
                              },
                              child: StreamBuilder(
                                stream: otherProfileService
                                    .fetchotherUserProfile(userId),
                                builder: ((context, snapshot) {
                                  OtherUserModel? user = snapshot.data;
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.connectionState ==
                                          ConnectionState.active ||
                                      snapshot.connectionState ==
                                          ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return const Center(
                                        child: Text("Could not fetch boom"),
                                      );
                                    } else if (snapshot.hasData) {
                                      List<String> fans = [];
                                      for (var item in user!.user!.funs!) {
                                        fans.add(item.id.toString());
                                      }
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
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
                                                  right: 12.0),
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
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0,
                                                              right: 4.0),
                                                      child: Text(
                                                        user.user!.location!
                                                                .isEmpty
                                                            ? "Location"
                                                            : user.user!
                                                                .location!,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Text(
                                                    "!${user.user!.username!.isNotEmpty ? user.user!.username : "username"}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          getProportionateScreenHeight(
                                                              15),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: myUserId ==
                                                            user.user!.id
                                                        ? const SizedBox()
                                                        : GestureDetector(
                                                            onTap: () {},
                                                            child: const Icon(
                                                              MdiIcons
                                                                  .dotsVertical,
                                                              size: 24,
                                                            ),
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                SizeConfig.screenHeight * 0.3,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: SizeConfig.screenWidth,
                                                  height:
                                                      getProportionateScreenHeight(
                                                          125),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                        user.user!.cover!,
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: user.user!.cover!,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Colors
                                                                  .black12),
                                                      width: SizeConfig
                                                          .screenWidth,
                                                      height:
                                                          getProportionateScreenHeight(
                                                              125),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  child: Container(
                                                    height:
                                                        getProportionateScreenHeight(
                                                            130),
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
                                                                user
                                                                    .user!
                                                                    .socialMedia!
                                                                    .twitter!,
                                                              ),
                                                            );
                                                          },
                                                          child: Icon(
                                                            MdiIcons.twitter,
                                                            size: 18,
                                                            color: user
                                                                    .user!
                                                                    .socialMedia!
                                                                    .twitter!
                                                                    .isEmpty
                                                                ? Colors.black26
                                                                : Colors
                                                                    .blueAccent,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await launchUrl(
                                                              Uri.parse(
                                                                user
                                                                    .user!
                                                                    .socialMedia!
                                                                    .facebook!,
                                                              ),
                                                            );
                                                          },
                                                          child: Icon(
                                                            MdiIcons.facebook,
                                                            size: 18,
                                                            color: user
                                                                    .user!
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
                                                                user
                                                                    .user!
                                                                    .socialMedia!
                                                                    .instagram!,
                                                              ),
                                                            );
                                                          },
                                                          child: Icon(
                                                            MdiIcons.instagram,
                                                            size: 18,
                                                            color: user
                                                                    .user!
                                                                    .socialMedia!
                                                                    .twitter!
                                                                    .isEmpty
                                                                ? Colors.black26
                                                                : Colors
                                                                    .purpleAccent,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await launchUrl(
                                                              Uri.parse(
                                                                user
                                                                    .user!
                                                                    .socialMedia!
                                                                    .tiktok!,
                                                              ),
                                                            );
                                                          },
                                                          child: Icon(
                                                            MdiIcons.musicNote,
                                                            size: 18,
                                                            color: user
                                                                    .user!
                                                                    .socialMedia!
                                                                    .twitter!
                                                                    .isEmpty
                                                                ? Colors.black26
                                                                : Colors
                                                                    .pinkAccent,
                                                          ),
                                                        )
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
                                                              child:
                                                                  Image.network(
                                                                height:
                                                                    getProportionateScreenHeight(
                                                                        60),
                                                                width:
                                                                    getProportionateScreenWidth(
                                                                        55),
                                                                user
                                                                        .user!
                                                                        .photo!
                                                                        .isEmpty
                                                                    ? "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/"
                                                                    : user.user!
                                                                        .photo!,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: user
                                                              .user!.isAdmin!,
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
                                                        )
                                                      ],
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
                                                // Positioned(
                                                //   top: 220,
                                                //   left: 30,
                                                //   child: Container(
                                                //     width:
                                                //         getProportionateScreenWidth(
                                                //             22),
                                                //     height:
                                                //         getProportionateScreenHeight(
                                                //             22),
                                                //     decoration: BoxDecoration(
                                                //       border: Border.all(
                                                //           color: Colors.black),
                                                //       gradient:
                                                //           const LinearGradient(
                                                //         begin:
                                                //             Alignment.topLeft,
                                                //         end: Alignment
                                                //             .bottomRight,
                                                //         colors: [
                                                //           kPrimaryColor,
                                                //           kSecondaryColor,
                                                //         ],
                                                //       ),
                                                //     ),
                                                //     child: const Icon(
                                                //       MdiIcons.swapVertical,
                                                //       size: 18,
                                                //     ),
                                                //   ),
                                                // ),
                                                Positioned(
                                                  top: 150,
                                                  left: 110,
                                                  child: SizedBox(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            250),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 12),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    boomCount
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          getProportionateScreenHeight(
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Booms",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          getProportionateScreenHeight(
                                                                              12),
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
                                                                        user.user!
                                                                            .funs
                                                                      ]);
                                                                },
                                                                child: Column(
                                                                  children: [
                                                                    Text(
                                                                      user
                                                                          .user!
                                                                          .funs!
                                                                          .length
                                                                          .toString(),
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
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    user
                                                                        .user!
                                                                        .friends!
                                                                        .length
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w800,
                                                                      fontSize:
                                                                          getProportionateScreenHeight(
                                                                              16),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    "Frens",
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          getProportionateScreenHeight(
                                                                              12),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width:
                                                                    getProportionateScreenWidth(
                                                                        40),
                                                              ),
                                                              myUserId ==
                                                                      user.user!
                                                                          .id
                                                                  ? const SizedBox()
                                                                  : Visibility(
                                                                      visible: !fans
                                                                          .contains(
                                                                              myUserId),
                                                                      child:
                                                                          Expanded(
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            await otherProfileService.followUser(user.user!.id!);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                getProportionateScreenWidth(40),
                                                                            height:
                                                                                getProportionateScreenHeight(25),
                                                                            alignment:
                                                                                Alignment.center,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(6),
                                                                              border: Border.all(color: Colors.black12),
                                                                              gradient: const LinearGradient(
                                                                                begin: Alignment.topLeft,
                                                                                end: Alignment.bottomRight,
                                                                                colors: [
                                                                                  kPrimaryColor,
                                                                                  kSecondaryColor,
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "Add",
                                                                              style: TextStyle(fontSize: getProportionateScreenHeight(13), fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                getProportionateScreenHeight(
                                                                    4),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              user.user!.bio!
                                                                      .isEmpty
                                                                  ? const Text(
                                                                      "User has no bio")
                                                                  : SizedBox(
                                                                      width: SizeConfig
                                                                              .screenWidth *
                                                                          0.5,
                                                                      child:
                                                                          Text(
                                                                        user.user!
                                                                            .bio!,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                              SizedBox(
                                                                width:
                                                                    getProportionateScreenWidth(
                                                                        40),
                                                              ),
                                                              myUserId ==
                                                                      user.user!
                                                                          .id
                                                                  ? const SizedBox()
                                                                  : Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          final otherProfileController =
                                                                              Get.find<OtherUserProfileController>();

                                                                          showModalBottomSheet(
                                                                              context: context,
                                                                              isScrollControlled: true,
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
                                                                              builder: (context) {
                                                                                return GetBuilder<OtherUserProfileController>(builder: (controller) {
                                                                                  return Container(
                                                                                    margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                    decoration: const BoxDecoration(
                                                                                      borderRadius: BorderRadius.only(
                                                                                        topLeft: Radius.circular(20),
                                                                                        topRight: Radius.circular(20),
                                                                                      ),
                                                                                    ),
                                                                                    height: SizeConfig.screenHeight * 0.3,
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(16.0),
                                                                                      child: Form(
                                                                                        key: otherProfileService.formKey,
                                                                                        child: Column(
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Center(
                                                                                              child: Text(
                                                                                                "Tip This User",
                                                                                                style: TextStyle(
                                                                                                  fontWeight: FontWeight.w800,
                                                                                                  fontSize: getProportionateScreenHeight(18),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: getProportionateScreenHeight(15),
                                                                                            ),
                                                                                            Text(
                                                                                              "Enter Amount to Tip",
                                                                                              style: TextStyle(
                                                                                                fontSize: getProportionateScreenHeight(14),
                                                                                                fontWeight: FontWeight.w500,
                                                                                                color: Colors.black45,
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: getProportionateScreenHeight(8),
                                                                                            ),
                                                                                            TextFormField(
                                                                                              controller: otherProfileService.amountController,
                                                                                              validator: (value) {
                                                                                                if (value!.isEmpty) {
                                                                                                  return "Amount cannot be empty";
                                                                                                }

                                                                                                return null;
                                                                                              },
                                                                                              decoration: InputDecoration(
                                                                                                contentPadding: const EdgeInsets.all(4.0),
                                                                                                suffixIcon: SizedBox(
                                                                                                  width: SizeConfig.screenWidth * 0.3,
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                                    children: [
                                                                                                      CachedNetworkImage(
                                                                                                        height: getProportionateScreenHeight(16),
                                                                                                        imageUrl: otherProfileController.selectedNetworkModel?.imageUrl ?? "",
                                                                                                      ),
                                                                                                      SizedBox(
                                                                                                        width: getProportionateScreenWidth(4),
                                                                                                      ),
                                                                                                      Text(
                                                                                                        "${otherProfileController.selectedNetwork}",
                                                                                                        style: TextStyle(
                                                                                                          fontWeight: FontWeight.w900,
                                                                                                          fontSize: getProportionateScreenHeight(12),
                                                                                                        ),
                                                                                                      ),
                                                                                                      DropdownButton(
                                                                                                          icon: const Icon(
                                                                                                            Icons.arrow_drop_down_circle_outlined,
                                                                                                            color: Colors.grey,
                                                                                                            size: 24,
                                                                                                          ),
                                                                                                          underline: const SizedBox(),
                                                                                                          style: const TextStyle(color: Colors.black),
                                                                                                          items: otherProfileController.networks.map((e) {
                                                                                                            return DropdownMenuItem(
                                                                                                                value: e,
                                                                                                                child: Row(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                  children: [
                                                                                                                    CachedNetworkImage(
                                                                                                                      height: getProportionateScreenHeight(16),
                                                                                                                      imageUrl: e.imageUrl!,
                                                                                                                    ),
                                                                                                                    SizedBox(
                                                                                                                      width: getProportionateScreenWidth(4),
                                                                                                                    ),
                                                                                                                    Text(
                                                                                                                      e.symbol!,
                                                                                                                      style: TextStyle(
                                                                                                                        fontWeight: FontWeight.w900,
                                                                                                                        fontSize: getProportionateScreenHeight(12),
                                                                                                                      ),
                                                                                                                    )
                                                                                                                  ],
                                                                                                                ));
                                                                                                          }).toList(),
                                                                                                          onChanged: (value) {
                                                                                                            otherProfileController.changeChain(value!.symbol!);
                                                                                                          }),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                                border: OutlineInputBorder(
                                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                                  borderSide: const BorderSide(
                                                                                                    color: Colors.black12,
                                                                                                  ),
                                                                                                ),
                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                                  borderSide: const BorderSide(
                                                                                                    color: Colors.black12,
                                                                                                  ),
                                                                                                ),
                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                                  borderSide: const BorderSide(
                                                                                                    color: Colors.black12,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            SizedBox(
                                                                                              height: getProportionateScreenHeight(15),
                                                                                            ),
                                                                                            Center(
                                                                                              child: GestureDetector(
                                                                                                onTap: () async {
                                                                                                  Get.back();
                                                                                                  await otherProfileService.tipUser(userId, otherProfileController.selectedNetwork!);
                                                                                                },
                                                                                                child: Container(
                                                                                                  width: SizeConfig.screenWidth * 0.8,
                                                                                                  height: getProportionateScreenHeight(45),
                                                                                                  decoration: BoxDecoration(
                                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                                    color: kSecondaryColor,
                                                                                                  ),
                                                                                                  alignment: Alignment.center,
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                                                                                    child: Text(
                                                                                                      "Tip User",
                                                                                                      style: TextStyle(
                                                                                                        fontWeight: FontWeight.w800,
                                                                                                        fontSize: getProportionateScreenHeight(16),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                });
                                                                              });
                                                                          // otherProfileService
                                                                          //     .tipUser();
                                                                        },
                                                                        child: SvgPicture
                                                                            .asset(
                                                                          height:
                                                                              getProportionateScreenHeight(22),
                                                                          "assets/icons/tip.svg",
                                                                        ),
                                                                      ),
                                                                    ),
                                                            ],
                                                          )

                                                          // const ListTile(
                                                          //   leading: Icon(MdiIcons.circleSmall),
                                                          // )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                              ),
                            ),
                          )
                        ];
                      },
                      body: StreamBuilder(
                        stream: otherProfileService.fetchUserBooms(userId),
                        builder: ((context, snapshot) {
                          OtherUserBooms? booms = snapshot.data;
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.connectionState ==
                                  ConnectionState.done ||
                              snapshot.connectionState ==
                                  ConnectionState.active) {
                            if (snapshot.hasError) {
                              return const Center(child: Text("Error"));
                            } else {
                              boomCount = booms!.booms.length;
                              return Container(
                                color: kContBgColor,
                                constraints: BoxConstraints(
                                  minHeight: SizeConfig.screenHeight * 0.38,
                                ),
                                height: SizeConfig.screenHeight * 0.39,
                                width: SizeConfig.screenWidth,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: booms.booms.isEmpty
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
                                          itemCount: booms.booms.length,
                                          itemBuilder: (context, index) {
                                            //Temp Solutiuon to change this later to only my Booms

                                            final singlePostDets = Get.find<
                                                OtherUserProfileController>();
                                            SingleBoomPost boomPost =
                                                singlePostDets
                                                    .getSingleBoomDetails(
                                                        booms.booms[index],
                                                        index);
                                            return SingleBoomWidget(
                                              post: boomPost,
                                              controller:
                                                  Get.find<HomeController>(),
                                              boomId: booms.booms[index].id!,
                                            );
                                          },
                                        ),
                                ),
                              );
                            }
                          } else {
                            return const Center(child: Text("Error"));
                          }
                        }),
                      )),
                ),
              ],
            ),
          ),
        ));

    // return GetBuilder<OtherUserProfileController>(builder: (controller) {});
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
