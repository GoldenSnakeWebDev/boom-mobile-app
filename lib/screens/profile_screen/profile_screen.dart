import 'package:boom_mobile/models/single_boom_post.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/profile_controller.dart';
import 'package:boom_mobile/screens/profile_screen/edit_profile.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/constants.dart';
import 'package:boom_mobile/utils/size_config.dart';
import 'package:boom_mobile/widgets/custom_app_bar.dart';
import 'package:boom_mobile/widgets/single_boom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
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
                              await controller.fetchProfile();
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: SizeConfig.screenWidth,
                                  height: getProportionateScreenHeight(28),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 6.0, bottom: 6.0, right: 24.0),
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
                                              getProportionateScreenHeight(28),
                                          decoration: const BoxDecoration(
                                            color: Colors.black,
                                          ),
                                          child: const Text(
                                            "Texas",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "!${controller.user?.username ?? "username"}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    15),
                                          ),
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () =>
                                              Get.to(() => const EditProfile()),
                                          child: const Icon(
                                            MdiIcons.accountEditOutline,
                                            size: 24,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.41,
                                  child: Stack(
                                    children: [
                                      controller.isNewUser
                                          ? GestureDetector(
                                              onTap: () async {},
                                              child: Container(
                                                width: SizeConfig.screenWidth,
                                                height:
                                                    getProportionateScreenHeight(
                                                        125),
                                                decoration: const BoxDecoration(
                                                    color: kContBgColor),
                                                child: ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxHeight:
                                                        getProportionateScreenHeight(
                                                            125),
                                                    maxWidth:
                                                        SizeConfig.screenWidth,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Add header Image",
                                                        style: TextStyle(
                                                          fontSize:
                                                              getProportionateScreenHeight(
                                                                  14),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            getProportionateScreenHeight(
                                                                10),
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black26),
                                                            shape: BoxShape
                                                                .circle),
                                                        child: const Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: SizeConfig.screenWidth,
                                              height:
                                                  getProportionateScreenHeight(
                                                      125),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    controller.user!.cover,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          height:
                                              getProportionateScreenHeight(130),
                                          width:
                                              getProportionateScreenWidth(30),
                                          decoration: const BoxDecoration(
                                              color: Colors.white),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: const [
                                              Icon(
                                                MdiIcons.twitter,
                                                size: 18,
                                                color: Colors.blueAccent,
                                              ),
                                              Icon(
                                                MdiIcons.facebook,
                                                size: 18,
                                                color: Colors.blue,
                                              ),
                                              Icon(
                                                MdiIcons.instagram,
                                                size: 18,
                                                color: Colors.purpleAccent,
                                              ),
                                              Icon(
                                                MdiIcons.musicNote,
                                                size: 18,
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
                                              getProportionateScreenWidth(60),
                                          height:
                                              getProportionateScreenHeight(70),
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                top: 10,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black12,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.network(
                                                      height:
                                                          getProportionateScreenHeight(
                                                              60),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              55),
                                                      controller.isNewUser
                                                          ? "https://bafkreihauwrqu5wrcwsi53fkmm75pcdlmbzcg7eorw6avmb3o3cx4tk33e.ipfs.nftstorage.link/"
                                                          : controller
                                                              .user!.photo,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: controller.isVerified,
                                                child: Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Container(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            20),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 1),
                                                      shape: BoxShape.circle,
                                                      color: kBlueColor,
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Text(
                                                        "B",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w900,
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
                                          onTap: () => _showComingSoon(),
                                          child: Image.network(
                                            height:
                                                getProportionateScreenHeight(
                                                    30),
                                            "https://bafybeiecd2ncp25fnbrcol3x6eowmfrt7sjwpdn244krddyof5rnri4dwy.ipfs.nftstorage.link/noob_talk.png",
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 180,
                                        right: 30,
                                        child: SvgPicture.asset(
                                          height:
                                              getProportionateScreenHeight(25),
                                          "assets/icons/tip.svg",
                                        ),
                                      ),
                                      Positioned(
                                        top: 220,
                                        right: 30,
                                        child: Image.network(
                                          height:
                                              getProportionateScreenHeight(25),
                                          "https://bafybeigmmfylly4mfjdtgjmdca2whhzxw63g2acsfbsdi2yyvpwxrwarcu.ipfs.nftstorage.link/nudge.png",
                                        ),
                                      ),
                                      Positioned(
                                        top: 220,
                                        left: 30,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
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
                                              const Icon(MdiIcons.swapVertical),
                                        ),
                                      ),
                                      Positioned(
                                        top: 150,
                                        left: 110,
                                        child: SizedBox(
                                          width:
                                              getProportionateScreenWidth(250),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 12),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .numberOfBooms
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    16),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Booms",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                    Column(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .numberOfFans
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    16),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Fans",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
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
                                                    Column(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .numberOfFrens
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    16),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Frens",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                getProportionateScreenHeight(
                                                                    12),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      getProportionateScreenHeight(
                                                          4),
                                                ),
                                                controller.isNewUser
                                                    ? TextButton(
                                                        onPressed: () {},
                                                        child: const Text(
                                                          "You have no Bio yet please add one",
                                                        ),
                                                      )
                                                    : Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              // const Icon(MdiIcons
                                                              //     .circleSmall),
                                                              Text(controller
                                                                  .user!.bio)
                                                            ],
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
                                      Positioned(
                                        top: 250,
                                        child: Container(
                                          color: kContBgColor,
                                          width: SizeConfig.screenWidth,
                                          height:
                                              getProportionateScreenHeight(115),
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: GridView.builder(
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
                                                        .changeSelectedIndex(
                                                            index);
                                                  },
                                                  child: Container(
                                                    width:
                                                        getProportionateScreenWidth(
                                                            70),
                                                    height:
                                                        getProportionateScreenHeight(
                                                            20),
                                                    margin:
                                                        const EdgeInsets.all(2),
                                                    decoration: BoxDecoration(
                                                      gradient: index ==
                                                              controller
                                                                  .selectedTab
                                                          ? const LinearGradient(
                                                              begin: Alignment
                                                                  .topLeft,
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
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        profileOptions[index]),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ];
                    },
                    body: Container(
                      color: kContBgColor,
                      constraints: BoxConstraints(
                        minHeight: SizeConfig.screenHeight * 0.38,
                      ),
                      height: SizeConfig.screenHeight * 0.39,
                      width: SizeConfig.screenWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                          itemCount: controller.booms.length,
                          itemBuilder: (context, index) {
                            //Temp Solutiuon to change this later to only my Booms
                            final allBooms = Get.find<HomeController>()
                                .allBooms!
                                .booms[index];
                            final network = Get.find<HomeController>()
                                .getNetworkById(allBooms.network);
                            final isLiked = Get.find<HomeController>().isLiked;
                            SingleBoomPost boomPost = SingleBoomPost(
                              boomType: allBooms.boomType,
                              location: "Location",
                              chain: allBooms.network,
                              imgUrl: allBooms.imageUrl,
                              desc: allBooms.description,
                              network: network,
                              isLiked: isLiked,
                              likes: 100 + index,
                              loves: 76 + index,
                              smiles: 20 + index,
                              rebooms: 5 + index,
                              reported: 2 + index,
                              comments: 3 + index,
                            );
                            return SingleBoomWidget(
                              post: boomPost,
                              controller: Get.find<HomeController>(),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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
